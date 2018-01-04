# coding: utf-8
# http://guides.rubyonrails.org/rails_application_templates.html
# https://github.com/morizyun/rails4_template/blob/master/app_template.rb
# https://github.com/search?q=rails%20template&source=c
#
# The method "insert_to_file" is defined by thor instead of rails
# https://github.com/erikhuda/thor/blob/master/lib/thor/actions/inject_into_file.rb

require 'bundler'
require 'fileutils'

def git_add_commit(msg, path = '.')
  git add: path
  raise "Failed to git add #{path.inspect} with exit code #{$?.inspect}" unless $? == 0
  git commit: "-m '#{msg}'"
  raise "Failed to git commit #{msg.inspect} with exit code #{$?.inspect}" unless $? == 0
end

def generate_with_git(arg)
  generate arg, '-f'
  git_add_commit "rails generate #{arg}"
end

def git_run(cmd)
  run cmd
  raise "Failed to run: #{cmd}" unless $? == 0
  git_add_commit cmd
end

def download_file(dest, url)
  FileUtils.mkdir_p File.dirname(dest)
  git_run "curl #{url} -o #{dest}"
end

def git_rake(*args)
  git_run "bin/rake %s" % args.join(" ")
end

def uncomment(path, target)
  text = IO.binread(path)
  text.sub!(/\#\s*#{Regexp.escape(target)}/, target)
  IO.binwrite(path, text)
end

git :init unless ENV['SKIP_GIT_INIT'] =~ /true|yes|on|1/i
git_add_commit "#{File.basename($PROGRAM_NAME)} #{ARGV.join(' ')}"

create_file '.gitignore', <<EOS
*.log
coverage
db/*.sqlite3
tmp/cache
EOS
git_add_commit "Add .gitignore file"

if File.exist?('README.rdoc') && !File.exist?('README.md')
  run 'mv README.rdoc README.md'
  git_add_commit "Rename README.rdoc to README.md"
end

## Gemfile

gem "twitter-bootstrap-rails"

gem 'devise'

# https://github.com/CanCanCommunity/cancancan
gem 'cancancan'

# https://github.com/brainspec/enumerize
gem 'enumerize'

gem "kaminari"

# # https://github.com/brainspec/enumerize
# gem 'enumerize'

# https://github.com/sinsoku/pretty_validation
# http://sinsoku.hatenablog.com/entry/2015/11/15/103924
gem 'pretty_validation', git: "https://github.com/akm/pretty_validation.git"

# # https://github.com/sferik/rails_admin
# gem 'rails_admin' unless ENV['DISABLE_RAILS_ADMIN'] =~ /true|yes|on|1/i

# Use dotenv to load environment variables
gem 'dotenv-rails', :require => 'dotenv/rails-now'

gem_group :development, :test do
  gem "rspec"
  gem "rspec-rails"
  gem 'simplecov'     , require: false
  gem 'simplecov-rcov', require: false
  gem "pry-rails"
  gem "pry-byebug"
  gem "pry-stack_explorer"
  gem "fuubar"
  gem "factory_bot"
  gem "factory_bot_rails"
  gem "annotate"
  gem "rails_best_practices"
  # https://github.com/flyerhzm/bullet
  gem 'bullet'  
end

gem_group :development do
  gem "better_errors"
  gem 'binding_of_caller'
end


gem_group :test do
  gem 'rails-controller-testing'
end

git_add_commit 'Add gems to Gemfile'

Bundler.with_clean_env do
  run 'bundle install'
end

git_add_commit 'bundle install'

# set config/application.rb
application  do
  %q{
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.i18n.default_locale = :ja

    config.generators do |g|
      # g.orm             :mongoid
      g.test_framework  :rspec
      g.factory_bot dir: 'spec/factories'
      # g.template_engine :haml
    end
  }
end

git_add_commit 'Add settings of timezone, locale and generators'

# Rails Japanese locale
download_file "config/locales/ja.yml", "https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml"

## rspec
generate_with_git 'rspec:install'
download_file ".rspec", "https://raw.githubusercontent.com/akm/rails_template/master/.rspec"

uncomment('spec/rails_helper.rb', "Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }")
git_add_commit 'Enable rb files under spec/support'



## simplecov
insert_into_file 'spec/rails_helper.rb', <<EOS, before: "# This file is copied to spec/ when you run 'rails generate rspec:install'"
# https://github.com/colszowka/simplecov
require 'simplecov'
SimpleCov.start 'rails'

EOS
git_add_commit 'Enable simplecov'


## twitter-bootstrap-rails
generate_with_git 'bootstrap:install static'
generate_with_git 'bootstrap:layout'

## kaminari
generate_with_git 'kaminari:views bootstrap3'

## Devise
generate_with_git 'devise:install'
download_file "config/locales/ja.devise.yml", "https://gist.githubusercontent.com/kawamoto/4729292/raw/80fd53034289be926de2e2206c2ab7afbac35993/devise.ja.yml"

# Flash messages are included in bootstrap views
# insert_into_file 'app/views/layouts/application.html.erb', <<EOS , after: '<body>'
#   <p class="notice"><%= notice %></p>
#   <p class="alert"><%= alert %></p>
#
# EOS

insert_into_file 'config/environments/development.rb', <<EOS, after: 'config.action_mailer.raise_delivery_errors = false'

  # for devise
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
EOS


root_path = (ENV['DISABLE_RAILS_ADMIN'] =~ /true|yes|on|1/i) ? 'welcome#index' : 'rails_admin/main#dashboard'
insert_into_file 'config/routes.rb', <<"EOS", after: 'Rails.application.routes.draw do'

  # root to: "devise/sessions#new" # Sign in
  root to: "#{root_path}" # TODO Change top page

EOS
git_add_commit 'Following instructions of devise:install'

generate_with_git 'devise User'

insert_into_file 'app/models/user.rb', <<EOS, before: 'end'

  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end

    def current(user)
      orig_user, User.current_user = User.current_user, user
      begin
        return yield
      ensure
        User.current_user = orig_user
      end
    end
  end

EOS
git_add_commit 'Add User.current_user'


# https://github.com/plataformatec/devise/wiki/I18n#japanese-devisejayml
download_file "config/locales/ja.devise.yml", "https://gist.githubusercontent.com/satour/6c15f27211fdc0de58b4/raw/d4b5815295c65021790569c9be447d15760f4957/devise.ja.yml"

insert_into_file 'spec/rails_helper.rb', <<EOS, after: '# Add additional requires below this line. Rails is not loaded until this point!'

# For spec/controllers
# https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-(and-RSpec)
require 'devise'

# For spec/requests
# https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara

EOS
git_add_commit 'Load devise on rails_helper'

## cancancan
generate_with_git 'cancan:ability'
insert_into_file 'app/models/ability.rb', <<EOS, after: '    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities'

    can :manage, :all
EOS

## bullet
insert_into_file 'config/environments/development.rb', <<EOS, after: "  # config.action_view.raise_on_missing_translations = true"

  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = false
    Bullet.bullet_logger = true
    Bullet.console = true
    # Bullet.growl = true
    # Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
    #                 :password => 'bullets_password_for_jabber',
    #                 :receiver => 'your_account@jabber.org',
    #                 :show_online_status => true }
    Bullet.rails_logger = true
    # Bullet.honeybadger = true
    # Bullet.bugsnag = true
    # Bullet.airbrake = true
    # Bullet.rollbar = true
    # Bullet.add_footer = true
    # Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
    # Bullet.stacktrace_excludes = [ 'their_gem', 'their_middleware' ]
    # Bullet.slack = { webhook_url: 'http://some.slack.url', foo: 'bar' }
  end

EOS
git_add_commit 'Add config for bullet'


# ## rails_admin
# unless ENV['DISABLE_RAILS_ADMIN'] =~ /true|yes|on|1/i
#   generate_with_git 'rails_admin:install'
#   download_file "config/locales/ja.rails_admin.yml", "https://raw.githubusercontent.com/starchow/rails_admin-i18n/master/locales/ja.yml"
# end

## model_base_generators
generate_with_git 'model_base:install'


## DB
git_rake "db:create db:migrate"

## gitguard
gem_group :development do
  # https://github.com/akm/gitguard
  gem 'gitguard'
end

generate_with_git "gitguard:install"

## The End
git commit: "-m \"\[COMPLETE\] rails new with akm/rails_template\" --allow-empty "

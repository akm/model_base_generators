require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

namespace :example do
  desc "Run spec in example"
  task :spec do
    target_rails_version = (ENV['BUNDLE_GEMFILE'] || 'rails-5.1').split('-').last
    Bundler.with_clean_env do
      ENV.delete('RAILS_ENV')
      ENV.delete('BUNDLE_GEMFILE')
      cmd = [
        "cd examples/rails-#{target_rails_version}",
        'bundle install',
        'bundle exec rake db:drop:all',
        'bundle exec rake db:schema:load',
        'bundle exec rake spec',
      ].join(' && ')
      unless system(cmd)
        raise "Failure: #{cmd}"
      end
    end
  end
end

task :default => [:spec, :'example:spec']

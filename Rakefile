require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

namespace :example do
  desc "Run spec in example"
  task :spec do
    target_rails_version = (ENV['BUNDLE_GEMFILE'] || 'rails-5.1').split('-').last
    Bundler.with_clean_env do
      cmd = [
        "cd examples/rails-#{target_rails_version}",
        'bundle',
        'rm -f db/*.sqlite3',
        'bundle exec rake db:create db:schema:load spec'
      ].join(' && ')
      unless system(cmd)
        raise "Failure: #{cmd}"
      end
    end
  end
end

task :default => [:spec, :'example:spec']

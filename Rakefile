require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

namespace :example do
  desc "Run spec in example"
  task :spec do
    Bundler.with_clean_env do
      cmd = 'cd example && bundle && rm -f db/*.sqlite3 && bundle exec rake db:create db:schema:load spec'
      unless system(cmd)
        raise "Failure: #{cmd}"
      end
    end
  end
end

task :default => [:spec, :'example:spec']

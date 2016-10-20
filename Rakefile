require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

namespace :dummy do
  desc "Run spec in spec/dummy"
  task :spec do
    Bundler.with_clean_env do
      cmd = 'cd spec/dummy && bundle && bundle exec rake spec'
      unless system(cmd)
        raise "Failure: #{cmd}"
      end
    end
  end
end

task :default => [:spec, :'dummy:spec']

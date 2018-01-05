require "simplecov"
SimpleCov.start do
  add_filter 'spec/dummy'
end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
target_rails_version = (ENV['BUNDLE_GEMFILE'] || 'rails-5.1').split('-').last
EXAMPLE_APP_PATH = File.expand_path("../../examples/rails-#{target_rails_version}", __FILE__)

require File.join(EXAMPLE_APP_PATH, "config/environment.rb")
ActiveRecord::Migrator.migrations_paths = [File.join(EXAMPLE_APP_PATH, "db/migrate")]

# require "rails/test_help"
if defined?(ActiveRecord::Base)
  ActiveRecord::Migration.maintain_test_schema!
end

require 'rspec/its'

require 'generator_spec'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].sort.each { |f| require f }

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "model_base"

ModelBase::Generators.enable!

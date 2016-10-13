require "simplecov"
SimpleCov.start do
  add_filter 'spec/dummy'
end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../spec/dummy/config/environment.rb", __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../spec/dummy/db/migrate", __FILE__)]
# require "rails/test_help"

require 'rspec/its'

require 'generator_spec'

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "model_base"

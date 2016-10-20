require "simplecov"
SimpleCov.start do
  add_filter 'spec/dummy'
end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../example/config/environment.rb", __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../example/db/migrate", __FILE__)]

# require "rails/test_help"
if defined?(ActiveRecord::Base)
  ActiveRecord::Migration.maintain_test_schema!
end

require 'rspec/its'

require 'generator_spec'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].sort.each { |f| require f }

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "model_base"

ModelBase.enable!

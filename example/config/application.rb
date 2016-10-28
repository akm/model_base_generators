require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "model_base"

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
      g.test_framework  :rspec
      g.factory_girl dir: 'spec/factories'
    end

    config.time_zone = 'Tokyo'
  end
end


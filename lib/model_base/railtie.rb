require 'model_base'

module ModelBase
  class Railtie < Rails::Railtie

    generators do |g|
      unless ModelBase.config.disabled
        ModelBase::Generators.enable!
      end
    end

  end
end

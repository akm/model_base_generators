require 'model_base'

module ModelBase
  class Railtie < Rails::Railtie

    generators do |g|
      require 'generators/model_base/scaffold/scaffold_generator'
    end

  end
end

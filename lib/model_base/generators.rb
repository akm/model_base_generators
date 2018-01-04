require 'model_base'

module ModelBase
  module Generators
    autoload :ModelSupport, 'model_base/generators/model_support'

    module Erb
      autoload :Scaffold, 'model_base/generators/erb/scaffold'
    end

    module FactoryBot
      autoload :Model, 'model_base/generators/factory_bot/model'
    end

    module Rails
      autoload :ScaffoldController, 'model_base/generators/rails/scaffold_controller'
    end

    class << self
      def enable!
        ::Rails::Generators::NamedBase.prepend(ModelSupport)
        templates_dir = File::expand_path('../../templates', __FILE__)
        ::Rails::Generators.templates_path.unshift(templates_dir)
        ::Rails::Generators.lookup(["rails:scaffold_controller"])
        ::Rails::Generators::ScaffoldControllerGenerator.source_paths.unshift(templates_dir)
        Erb::Scaffold.enable!
        FactoryBot::Model.enable!
        Rails::ScaffoldController.enable!
      end
    end

  end
end

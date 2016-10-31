require "model_base"

require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'

module ModelBase
  module Generators
    module Rails

      module ScaffoldController
        def self.enable!
          ::Rails::Generators::ScaffoldControllerGenerator.prepend(self)
        end

        def create_controller_files
          name =
            File.join(controller_class_path, controller_file_name).
              strip.sub(/\A\//, '')
          ModelBase.add_generated_controller(name)
          super
        end
      end

    end
  end
end

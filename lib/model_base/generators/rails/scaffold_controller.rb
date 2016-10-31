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
          controller_name = File.join(controller_class_path, controller_file_name)
          path = File.join(ModelBase.config.home_dir, 'controllers').to_s
          FileUtils.mkdir_p(File.dirname(path))
          names = File.readable?(path) ? File.read(path).lines.map(&:strip) : []
          names << controller_name.strip.sub(/\A\//, '')
          open(path, 'w'){|f| f.puts(names.uniq.join("\n")) }
          super
        end
      end

    end
  end
end

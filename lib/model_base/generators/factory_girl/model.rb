require "model_base"

require 'generators/factory_girl/model/model_generator'

module ModelBase
  module Generators
    module FactoryGirl

      module Model
        def self.enable!
          ::FactoryGirl::Generators::ModelGenerator.prepend(self)
          ::FactoryGirl::Generators::ModelGenerator.module_eval do
            source_paths << File.expand_path("../../../../templates/helper/templates", __FILE__)
          end
        end

        private

        def create_factory_file
          file = File.join(options[:dir], "#{filename}.rb")
          create_file(file, single_file_factory_definition)
        end


      end
    end
  end
end

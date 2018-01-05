require "model_base"

require 'generators/factory_bot/model/model_generator'

module ModelBase
  module Generators
    module FactoryBot

      module Model
        def self.enable!
          ::FactoryBot::Generators::ModelGenerator.prepend(self)
          ::FactoryBot::Generators::ModelGenerator.extend(ClassMethod)
          ::FactoryBot::Generators::ModelGenerator.instance_eval do
            source_root File.expand_path("../../../../templates/factory_bot", __FILE__)
          end
        end

        module ClassMethod
          # To overwrite `source_root` again, which is overwritten by factory_bot_rails
          # https://github.com/thoughtbot/factory_bot_rails/blob/master/lib/generators/factory_bot.rb#L6-L8
          # https://github.com/rails/rails/blob/master/railties/lib/rails/generators/base.rb#L22-L26
          def source_root(path=nil)
            @_source_root = path if path
            @_source_root ||= default_source_root
          end
        end

        private

        def create_factory_file
          template 'factory.rb', File.join(options[:dir], "#{filename}.rb")
        end

      end
    end
  end
end

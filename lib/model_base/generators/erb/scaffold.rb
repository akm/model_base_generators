require "model_base"

require 'rails/generators/erb/scaffold/scaffold_generator'

module ModelBase
  module Generators
    module Erb

      module Scaffold
        def self.enable!
          ::Erb::Generators::ScaffoldGenerator.prepend(self)
        end

        protected

        def available_views
          %w(index edit show new _form _table)
        end
      end

    end
  end
end

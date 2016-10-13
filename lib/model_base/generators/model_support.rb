require 'model_base'

require 'rails/generators'

module ModelBase
  module Generators
    module ModelSupport
      def self.included(klass)
        klass.send :include, ::Rails::Generators::ResourceHelpers
      end

      def initialize(args, *options)
        super(args, *options)
        @model_name = (class_path + [@name.singularize.camelize]).join('::') unless @model_name
        @model_name = @model_name.camelize
      end

      protected

      def model
        @model ||= ModelBase::MetaModel.new(@model_name)
      end

      def controller_routing_path
        ActiveModel::Naming.route_key(@model_name.constantize)
      end

      def singular_controller_routing_path
        ActiveModel::Naming.singular_route_key(@model_name.constantize)
      end

    end
  end
end

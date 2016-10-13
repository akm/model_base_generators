require 'rails/generators'
require 'rails/generators/generated_attribute'

module ModelBase
  module Generators
    class Base < ::Rails::Generators::NamedBase
      include ::Rails::Generators::ResourceHelpers

      argument :model_name,         :type => :string, :required => false

      def initialize(args, *options)
        super(args, *options)
        # binding.pry
        @model_name = (class_path + [@name.singularize.camelize]).join('::') unless @model_name
        @model_name = @model_name.camelize
        @model = ModelBase::MetaModel.new(@model_name)
      end

      protected

      attr_reader :model

      def controller_routing_path
        ActiveModel::Naming.route_key(@model_name.constantize)
      end

      def singular_controller_routing_path
        ActiveModel::Naming.singular_route_key(@model_name.constantize)
      end

    end
  end
end

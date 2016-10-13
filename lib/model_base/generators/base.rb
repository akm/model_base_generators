require 'rails/generators'
require 'rails/generators/generated_attribute'

module ModelBase
  module Generators
    class Base < ::Rails::Generators::NamedBase
      argument :model_name,         :type => :string, :required => false

      def initialize(args, *options)
        super(args, *options)
        initialize_views_variables
      end

      protected

      def initialize_views_variables
        @base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(controller_path)
        @controller_routing_path = @controller_file_path.gsub(/\//, '_')
        @model_name = @controller_class_nesting + "::#{@base_name.singularize.camelize}" unless @model_name
        @model_name = @model_name.camelize
        @model = ModelBase::MetaModel.new(@model_name)
      end

      attr_reader :model
      alias_method :controller_path, :name

      def controller_routing_path
        ActiveModel::Naming.route_key(@model_name.constantize)
      end

      def singular_controller_routing_path
        ActiveModel::Naming.singular_route_key(@model_name.constantize)
      end

      def extract_modules(name)
        modules = name.include?('/') ? name.split('/') : name.split('::')
        name    = modules.pop
        path    = modules.map { |m| m.underscore }
        file_path = (path + [name.underscore]).join('/')
        nesting = modules.map { |m| m.camelize }.join('::')
        [name, path, file_path, nesting, modules.size]
      end

    end
  end
end

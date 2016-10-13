require 'rails/generators'
require 'rails/generators/generated_attribute'

module ModelBase
  module Generators
    class ViewsGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      argument :model_name,         :type => :string, :required => false
      argument :layout,             :type => :string, :default => "application",
                                    :banner => "Specify application layout"

      class_option :excluded_columns, :type => :array, :required => false

      def initialize(args, *options)
        super(args, *options)
        initialize_views_variables
      end

      def copy_views
        generate_views
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

      def generate_views
        options.engine == generate_erb(selected_views)
      end

      def selected_views
        {
          "index.html.#{ext}"                 => File.join('app/views', @controller_file_path, "index.html.#{ext}"),
          "new.html.#{ext}"                   => File.join('app/views', @controller_file_path, "new.html.#{ext}"),
          "edit.html.#{ext}"                  => File.join('app/views', @controller_file_path, "edit.html.#{ext}"),
          "#{form_builder}_form.html.#{ext}"  => File.join('app/views', @controller_file_path, "_form.html.#{ext}"),
          "show.html.#{ext}"                  => File.join('app/views', @controller_file_path, "show.html.#{ext}")
        }
      end

      def generate_erb(views)
        views.each do |template_name, output_path|
          template template_name, output_path
        end
      end

      def ext
        ::Rails.application.config.generators.options[:rails][:template_engine] || :erb
      end

      def form_builder
        defined?(::SimpleForm) ? 'simple_form/' : ''
      end
    end
  end
end

require 'model_base/generators/base'

module ModelBase
  module Generators
    class ViewsGenerator < ::ModelBase::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :layout,             :type => :string, :default => "application",
                                    :banner => "Specify application layout"

      class_option :excluded_columns, :type => :array, :required => false

      def copy_views
        generate_views
      end

      protected

      def generate_views
        options.engine == generate_erb(selected_views)
      end

      def selected_views
        {
          "index.html.#{ext}"                 => File.join('app/views', class_path, controller_file_path, "index.html.#{ext}"),
          "new.html.#{ext}"                   => File.join('app/views', class_path, controller_file_path, "new.html.#{ext}"),
          "edit.html.#{ext}"                  => File.join('app/views', class_path, controller_file_path, "edit.html.#{ext}"),
          "#{form_builder}_form.html.#{ext}"  => File.join('app/views', class_path, controller_file_path, "_form.html.#{ext}"),
          "show.html.#{ext}"                  => File.join('app/views', class_path, controller_file_path, "show.html.#{ext}")
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

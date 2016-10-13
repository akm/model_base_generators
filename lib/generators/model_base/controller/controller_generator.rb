require 'model_base/generators/model_support'

module ModelBase
  module Generators
    class ControllerGenerator < ::Rails::Generators::NamedBase # :nodoc:
      include ::ModelBase::Generators::ModelSupport

      source_root File.expand_path('../templates', __FILE__)

      check_class_collision suffix: "Controller"

      class_option :helper, type: :boolean
      class_option :orm, banner: "NAME", type: :string, required: true,
                         desc: "ORM to generate the controller for"
      class_option :api, type: :boolean,
                         desc: "Generates API controller"

      def create_controller_files
        template_file = options.api? ? "api_controller.rb.erb" : "controller.rb.erb"
        template template_file, File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      end

      # Invoke the helper using the controller name (pluralized)
      hook_for :helper, as: :scaffold do |invoked|
        invoke invoked, [ controller_name ]
      end
    end
  end
end

require 'model_base'

module ModelBase
  class Railtie < Rails::Railtie

    generators do |g|
      unless ModelBase.config.disabled
        require 'model_base/generators/model_support'
        ::Rails::Generators::NamedBase.prepend(::ModelBase::Generators::ModelSupport)
        templates_dir = File::expand_path('../../templates', __FILE__)
        Rails::Generators.templates_path.unshift(templates_dir)
        Rails::Generators.lookup(["rails:scaffold_controller"])
        Rails::Generators::ScaffoldControllerGenerator.source_paths.unshift(templates_dir)
      end
    end

  end
end

require "model_base/version"

module ModelBase

  autoload :ColumnAttribute, 'model_base/column_attribute'
  autoload :Configuration, 'model_base/config'
  autoload :MetaModel    , 'model_base/meta_model'

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Configuration.new
    end

    def enable!
      require 'model_base/generators/model_support'
      ::Rails::Generators::NamedBase.prepend(::ModelBase::Generators::ModelSupport)
      templates_dir = File::expand_path('../templates', __FILE__)
      Rails::Generators.templates_path.unshift(templates_dir)
      Rails::Generators.lookup(["rails:scaffold_controller"])
      Rails::Generators::ScaffoldControllerGenerator.source_paths.unshift(templates_dir)
      require 'model_base/generators/erb/scaffold'
      ::ModelBase::Generators::Erb::Scaffold.enable!
    end
  end
end
require 'model_base/railtie' if defined?(Rails)

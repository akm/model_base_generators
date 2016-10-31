require "model_base/version"

module ModelBase

  autoload :ColumnAttribute, 'model_base/column_attribute'
  autoload :Configuration, 'model_base/config'
  autoload :Generators   , 'model_base/generators'
  autoload :MetaModel    , 'model_base/meta_model'

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Configuration.new
    end

    def base_time
      Time.zone.parse(config.base_time)
    end

    def skipped_file?(path)
      config.skipped_files.any? do |ptn|
        File.fnmatch?(ptn, path, File::FNM_EXTGLOB)
      end
    end

    def generated_controllers_path
      File.join(ModelBase.config.home_dir, 'controllers').to_s
    end

    def generated_controllers
      path = generated_controllers_path
      File.readable?(path) ? File.read(path).lines.map(&:strip) : []
    end

    def add_generated_controller(name)
      path = ModelBase.generated_controllers_path
      FileUtils.mkdir_p(File.dirname(path))
      names = generated_controllers
      names << name
      open(path, 'w'){|f| f.puts(names.uniq.join("\n")) }
    end
  end
end
require 'model_base/railtie' if defined?(Rails)

require "model_base/version"

module ModelBase

  autoload :Configuration, 'model_base/config'
  autoload :MetaModel    , 'model_base/meta_model'

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Configuration.new
    end
  end
end

require 'model_base'

module ModelBase
  class ColumnAttribute < ::Rails::Generators::GeneratedAttribute
    attr_accessor :linkable
    alias_method :linkable?, :linkable

    def initialize(name, type, linkable: false, index_type: false, attr_options: {})
      super(name, type, index_type, attr_options)
    end
  end

end

require 'model_base'

module ModelBase
  class ColumnAttribute < ::Rails::Generators::GeneratedAttribute
    attr_accessor :linkable
    alias_method :linkable?, :linkable

    attr_reader :reference

    def initialize(name, type, reference: nil, index_type: false, attr_options: {})
      super(name, type, index_type, attr_options)
      @reference = reference
    end

    def ref_model
      unless defined?(@ref_model)
        @ref_model = reference.nil? ? nil : ModelBase::MetaModel.new(reference.class_name)
      end
      @ref_model
    end
  end

end

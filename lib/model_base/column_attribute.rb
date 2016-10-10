require 'model_base'

module ModelBase
  class ColumnAttribute < ::Rails::Generators::GeneratedAttribute
    attr_accessor :linkable
    alias_method :linkable?, :linkable

    attr_reader :reference
    attr_reader :column

    class << self
      def from_col(col, reference: nil)
        ColumnAttribute.new(col.name, col.type, column: col, reference: reference)
      end
    end

    def initialize(name, type, column: nil, reference: nil, index_type: false, attr_options: {})
      super(name, type, index_type, attr_options)
      @reference = reference
      @column = column
    end

    def ref_model
      unless defined?(@ref_model)
        @ref_model = reference.nil? ? nil : ModelBase::MetaModel.new(reference.class_name)
      end
      @ref_model
    end

    def selectable?
      !!ref_model
    end

    def select_choices_expression(taregt_name)
      query =
        ref_model.respond_to?(:choices_for) ?
          "#{ref_model.name}.choices_for(#{taregt_name})" :
          "#{ref_model.name}.all"
      "options_from_collection_for_select(#{qeury}, :id, :#{ref_model.title_column.name}x)"
    end

    def select_options
      r = {}
      r[:include_blank] = !required?
      r
    end

    def required?
      !column.try(:null)
    end
  end

end

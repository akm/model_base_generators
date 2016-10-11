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

    def required?
      !column.try(:null)
    end

    def select_renderer
      red_model ? ReferenceSelectRenderer.new(self) : nil
    end

    class ReferenceSelectRenderer
      attr_reader :column_attr
      def initialize(column_attr)
        @column_attr = column_attr
      end

      def render(form_name, target_name, options)
        ref_model = column_attr.ref_model
        query =
          ref_model.respond_to?(:choices_for) ?
            "#{ref_model.name}.choices_for(#{taregt_name})" :
            "#{ref_model.name}.all"
        options_exp = {include_blank: !column_attr.required?}.inspect.gsub(/\A\{|\}\z/, '')
        r = "#{form_name}.collection_select :#{@column_attr.name}, #{query}, :id, :#{ref_model.title_column.name}"
        html = optinos.delete(:html) || {}
        html_exp = html.empty? ? nil : html.inspect.gsub(/\A\{|\}\z/, '')
        r << ", #{html}" if html
        r
      end
    end
  end

end

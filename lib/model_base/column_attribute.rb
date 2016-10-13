require 'model_base'

require 'rails/generators/generated_attribute'

module ModelBase
  class ColumnAttribute < ::Rails::Generators::GeneratedAttribute
    attr_accessor :linkable
    alias_method :linkable?, :linkable

    attr_reader :reference
    attr_reader :model, :column

    def initialize(model, name, type, column: nil, reference: nil, index_type: false, attr_options: {})
      super(name, type, index_type, attr_options)
      @model = model
      @reference = reference
      @column = column
    end

    def ref_model
      unless defined?(@ref_model)
        @ref_model = reference.nil? ? nil : ModelBase::MetaModel.new(reference.class_name)
      end
      @ref_model
    end

    def required?
      !column.try(:null)
    end

    def enumerized?
      model.model_class.respond_to?(name) &&
        defined?(Enumerize) && model.model_class.send(name).is_a?(Enumerize::Attribute)
    end

    def select_renderer
      ref_model ? ReferenceSelectRenderer.new(self) :
        enumerized? ? EnumerizedSelectRenderer.new(self) : nil
    end

    class AbstractSelectRenderer
      attr_reader :column_attr
      def initialize(column_attr)
        @column_attr = column_attr
      end

      def render(form_name, target_name, options = {})
        html = options.delete(:html) || {}
        html_exp = html.empty? ? nil : html.inspect.gsub(/\A\{|\}\z/, '')
        options.update(include_blank: !column_attr.required?)
        options_exp = {}.inspect
        r = render_core(form_name, target_name)
        r << ", #{options_exp}"
        r << ", #{html_exp}" if html
        r
      end
    end

    class ReferenceSelectRenderer < AbstractSelectRenderer
      def render_core(form_name, target_name, options = {})
        ref_model = column_attr.ref_model
        query =
          ref_model.respond_to?(:choices_for) ?
            "#{ref_model.name}.choices_for(#{taregt_name})" :
            "#{ref_model.name}.all"
        "#{form_name}.collection_select :#{column_attr.name}, #{query}, :id, :#{ref_model.title_column.name}"
      end
    end

    class EnumerizedSelectRenderer < AbstractSelectRenderer
      def render(form_name, target_name, options = {})
        "#{form_name}.select :#{column_attr.name}, #{column_attr.model.name}.#{column_attr.name}.optoins"
      end
    end
  end

end

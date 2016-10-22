require 'model_base'

require 'rails/generators/generated_attribute'

module ModelBase
  class ColumnAttribute < ::Rails::Generators::GeneratedAttribute
    attr_accessor :linkable
    alias_method :linkable?, :linkable

    attr_reader :reference
    attr_reader :model, :column

    def initialize(model, name, type, column: nil, reference: nil, index_type: false, title: false, attr_options: {})
      super(name, type, index_type, attr_options)
      @model = model
      @reference = reference
      @column = column
      @title = !!title
    end

    def title?
      @title
    end
    attr_writer :title

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

    def input_type
      select_renderer ? :select : super
    end

    LOCALIZED_TYPES = [:time, :datetime].freeze
    def to_be_localized?
      LOCALIZED_TYPES.include?(type)
    end

    def sample_value(idx = 1, context: nil)
      if name == 'id'
        idx
      elsif name == 'email' && type == :string
        'user1@example.com'
      elsif title?
        model.full_resource_name + idx.to_s
      elsif ref_model
        if tc = ref_model.title_column
          tc.sample_value(idx)
        else
          1
        end
      elsif enumerized?
        enum = model.model_class.send(name)
        r = enum.values.first
        context == :factory ? r.to_sym : r.text
      else
        @default ||= case type
          when :integer                     then idx
          when :float                       then idx + 0.5
          when :decimal                     then "#{idx}.99"
          when :datetime, :timestamp, :time then Time.now.to_s(:db)
          when :date                        then Date.today.to_s(:db)
          when :string                      then
            case name
            when 'type' then ""
            else "#{model.full_resource_name}_#{name}_#{idx}"
            end
          when :text                        then "#{model.full_resource_name}_#{name}_#{idx}"
          when :boolean                     then false
          when :references, :belongs_to     then nil
          else
            ""
        end
      end
    end

    def sample_string(idx = 1)
      "'%s'" % sample_value(idx)
    end

    def new_attribute_exp
      if enumerized?
        '%s.%s.values[%d]' % [model.name, name, 1] # 2nd value
      elsif type == :boolean
        "valid_parameters[:#{name}].!"
      else
        "valid_parameters[:#{name}].succ"
      end
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
        r << ", #{html_exp}" unless html.empty?
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
      def render_core(form_name, target_name, options = {})
        "#{form_name}.select :#{column_attr.name}, #{column_attr.model.name}.#{column_attr.name}.options"
      end
    end
  end

end

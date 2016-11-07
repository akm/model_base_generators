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
      column ? !column.null : false
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

    def single_sample_only?
      ref_model || enumerized? ||
        case type
        when :boolean, :datetime, :timestamp, :time, :date then true
        else false
        end
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
        case type
          when :integer                     then idx
          when :float                       then idx + 0.5
          when :decimal                     then "#{idx}.99"
          when :datetime, :timestamp, :time then sample_time(idx).strftime('%F %T %:z')
          when :date                        then sample_time(idx).to_date.to_s(:db)
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

    def base_sample_value
      name.split('').map(&:ord).sum
    end

    def sample_time(idx = 1)
      ModelBase.base_time +
        model.sample_value.hours +
        (base_sample_value.minutes * 10 * idx)
    end

    def sample_value_regexp_exp(idx = 1)
      case type
      when :datetime, :timestamp, :time
        "localized_time_re('%s')" % sample_value(idx)
      else
        '/%s/' % sample_value(idx)
      end
    end

    def assert_select_exp
      model_name = model.full_resource_name
      case type
      when :datetime, :timestamp, :time
        "assert_select_datetime_field :#{model_name}, :#{name}"
      else
        "assert_select '#{ input_type }##{ model_name }_#{ name }[name=?]', '#{ model_name }[#{ name }]'"
      end
    end

    def sample_string_exp(idx = 1)
      case type
      when :datetime, :timestamp, :time
        'localize(Time.zone.parse(\'%s\'))' % sample_value(idx)
      else
        "'%s'" % sample_value(idx)
      end
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
        options.update(include_blank: true) if !column_attr.required?
        options_exp = '{%s}' % options.map{|k,v| "#{k}: #{v.inspect}"}.join(', ')
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
        tc = ref_model.title_column
        "#{form_name}.collection_select :#{column_attr.name}, #{query}, :id, :#{tc ? tc.name : 'title'}"
      end
    end

    class EnumerizedSelectRenderer < AbstractSelectRenderer
      def render_core(form_name, target_name, options = {})
        "#{form_name}.select :#{column_attr.name}, #{column_attr.model.name}.#{column_attr.name}.options"
      end
    end
  end

end

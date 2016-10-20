require "model_base"

module ModelBase
  class MetaModel

    attr_reader :name
    def initialize(name)
      @name = name
    end

    alias_method :class_name, :name

    def plural_name
      name.pluralize
    end

    def resource_name
      name.demodulize.underscore
    end

    def plural_resource_name
      resource_name.pluralize
    end

    def full_resource_name
      name.underscore.gsub('/', '_').sub(/\A_/, '')
    end

    def plural_full_resource_name
      full_resource_name.pluralize
    end

    def model_class
      @model_class ||= name.constantize
    end

    def active_record?
      defined?(ActiveRecord) == "constant" && ActiveRecord.class == Module && model_class < ActiveRecord::Base
    end

    def title_column
      retrieve_columns unless defined?(@title_column)
      @title_column
    end

    def retrieve_columns
      raw_cols = active_record? ? model_class.columns : model_class.fields.map {|c| c[1] }
      belongs_to_refs = model_class.reflections.values.select{|ref| ref.is_a?(ActiveRecord::Reflection::BelongsToReflection) }
      cols = raw_cols.map do |col|
        ref = belongs_to_refs.detect{|ref| ref.foreign_key == col.name}
        ColumnAttribute.new(self, col.name, col.type, reference: ref)
      end
      @title_column = nil
      ModelBase.config.title_column_candidates.each do |tcc|
        @title_column = cols.detect{|col| tcc === col.name}
        if @title_column
          @title_column.title = true
          break
        end
      end
      @title_column.linkable = true if @title_column
      cols
    end

    def raw_columns
      @raw_columns ||= retrieve_columns
    end

    def columns
      @columns ||=
        title_column ? raw_columns : [ColumnAttribute.new(self, :id, :integer, title: true)] + raw_columns
    end

    def columns_for(type)
      case type
      when :form, :index, :show
        columns.reject{|c| exclude_for?(type, c) }
      when :params
        columns_for(:form).reject{|c| c.name == 'id'}
      else
        raise "Unknown template type: #{type.inspect}"
      end
    end

    def exclude_for?(type, col_attr)
      excluded_columns = ModelBase.config.send("excluded_columns_of_#{type}")
      excluded_columns.any?{|ex| ex === col_attr.name && !col_attr.title? }
    end

    def dependencies(required = true)
      # c: c.required?
      # r: required (the argument)
      #
      # | c \ r | true  | false |
      # |-------|-------|-------|
      # | true  | true  | true  |
      # | false | false | true  |
      raw_columns.select{|c| !required || c.required? }.
        select(&:ref_model).
        each_with_object({}){|c,d| d[c.name] = c.ref_model}
    end

    def all_dependencies(required = true)
      dependencies.values.map{|m| [m] + m.dependencies(required).values}.flatten.uniq(&:name)
    end

    def factory_girl_options
      dependencies.map{|attr, model| "#{attr.sub(/_id\z/, '')}: #{model.full_resource_name}"}
    end

    def factory_girl_create
      factory_girl_method(:create)
    end

    def factory_girl_build
      factory_girl_method(:build)
    end

    def factory_girl_method(name)
      options = factory_girl_options
      options_str = options.empty? ? '' : ', ' <<  factory_girl_options.join(', ')
      'FactoryGirl.%s(:%s%s)' % [name, full_resource_name, options_str]
    end

    def factory_girl_let_definition
      'let(:%s){ %s }' % [full_resource_name, factory_girl_create]
    end
  end
end

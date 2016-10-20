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
      columns.reject{|c| exclude_for?(type, c) }
    end

    def exclude_for?(type, col_attr)
      excluded_columns = ModelBase.config.send("excluded_columns_of_#{type}")
      excluded_columns.any?{|ex| ex === col_attr.name && !col_attr.title? }
    end

  end
end

require "model_base"

module ModelBase
  class MetaModel

    DEFAULT_EXCLUDED_COLUMNS = [
      /.*_checksum/,
      /.*_count/,
    ] + %w[_id _type id created_at updated_at]

    attr_reader :name, :excluded_columns
    def initialize(name, excluded_columns: DEFAULT_EXCLUDED_COLUMNS)
      @name = name
      @excluded_columns = excluded_columns
    end

    alias_method :class_name, :name

    def plural_model_name
      @model_name.pluralize
    end

    def resource_name
      @model_name.demodulize.underscore
    end

    def plural_resource_name
      resource_name.pluralize
    end

    def columns
      retrieve_columns.reject {|c| excluded?(c.name) }.map do |c|
        new_attribute(c.name, c.type.to_s)
      end
    end

    def model_class
      @model_class ||= model_name.constantize
    end

    def active_record?
      defined?(ActiveRecord) == "constant" && ActiveRecord.class == Module && model_class < ActiveRecord::Base
    end

    def retrieve_columns
      if active_record?
        model_class.columns
      else
        model_class.fields.map {|c| c[1] }
      end
    end

    def excluded?(name)
      excluded_columns.any?{|c| === name}
    end

    def new_attribute(name, type)
      ::Rails::Generators::GeneratedAttribute.new(name, type)
    end

  end
end

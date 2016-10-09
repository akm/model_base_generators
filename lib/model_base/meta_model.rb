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

    def columns
      retrieve_columns.reject {|c| excluded?(c.name) }.map do |c|
        new_attribute(c.name, c.type.to_s)
      end
    end

    def model_class
      @model_class ||= name.constantize
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
      ModelBase.config.excluded_columns.any?{|c| c === name}
    end

    def new_attribute(name, type)
      ::Rails::Generators::GeneratedAttribute.new(name, type)
    end

  end
end

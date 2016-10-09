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
      @columns ||= retrieve_columns.reject {|c| excluded?(c.name) }
    end

    def model_class
      @model_class ||= name.constantize
    end

    def active_record?
      defined?(ActiveRecord) == "constant" && ActiveRecord.class == Module && model_class < ActiveRecord::Base
    end

    def retrieve_columns
      raw_cols = active_record? ? model_class.columns : model_class.fields.map {|c| c[1] }
      cols = raw_cols.map{|col| ColumnAttribute.new(col.name, col.type) }
      title_col = nil
      ModelBase.config.title_column_candidates.each do |tcc|
        title_col = cols.detect{|col| tcc === col.name}
        break if title_col
      end
      title_col.linkable = true if title_col
      cols
    end

    def excluded?(name)
      ModelBase.config.excluded_columns.any?{|c| c === name}
    end

    def new_attribute(name, type, linkable=false)
      ColumnAttribute.new(name, type).tap{|a| a.linkable = linkable}
    end

    def title_column
      unless defined?(@title_column)
        @title_colunm = nil
        ModelBase.config.title_column_candidates.each do |tcc|
          @title_column = columns.detect{|col| tcc === col.name}
          if @title_colunm
            @title_colunm.linkable = true
            break
          end
        end
      end
      @title_colunm
    end

    def display_columns
      @dispaly_columns ||=
        title_column ? columns : [new_attribute(:id, :integer, true)] + columns
    end

  end
end

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
        ColumnAttribute.new(self, col.name, col.type, column: col, reference: ref)
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

    def [](name)
      raw_columns.detect{|c| c.name == name.to_s}
    end

    def columns
      @columns ||=
        title_column ? raw_columns : [ColumnAttribute.new(self, 'id', :integer, title: true)] + raw_columns
    end

    SPEC_EXCLUSED_COLS = %w[id created_at updated_at]
    def columns_for(type)
      case type
      when :form, :index, :show
        columns.reject{|c| exclude_for?(type, c) }
      when :params     then columns_for(:form).reject{|c| c.name.to_s == 'id'}
      when :spec_index then columns_for(:index).reject{|c| SPEC_EXCLUSED_COLS.include?(c.name)}
      when :spec_show  then columns_for(:show ).reject{|c| SPEC_EXCLUSED_COLS.include?(c.name)}
      when :factory     then columns_for(:params).reject{|c| SPEC_EXCLUSED_COLS.include?(c.name)}
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
        select(&:reference).
        each_with_object({}){|c,d| d[c.reference.name] = c.ref_model }
    end

    def all_dependencies(required = true)
      dependencies.values.map{|m| [m] + m.all_dependencies(required)}.flatten.uniq(&:name)
    end

    def factory_bot_options
      dependencies.map{|attr, model| "#{attr}: #{model.full_resource_name}" }
    end

    def factory_bot_method(name, extra)
      extra_str = extra.blank? ? '' : ', ' << extra.map{|k,v| "#{k}: '#{v}'"}.join(', ')
      options = factory_bot_options
      options_str = options.empty? ? '' : ', ' <<  factory_bot_options.join(', ')
      'FactoryBot.%s(:%s%s%s)' % [name, full_resource_name, options_str, extra_str]
    end

    def factory_bot_to(name, context: nil, index: 1, extra: {})
      case context
      when :spec_index
        columns_for(:spec_index).delete_if(&:single_sample_only?).delete_if(&:reference).each do |col|
          extra[col.name] = col.sample_value(index)
        end
      end
      factory_bot_method(name, extra)
    end

    def factory_bot_let_definition(action: :create)
      'let(:%s) { %s }' % [full_resource_name, factory_bot_to(action)]
    end

    def factory_bot_let_definitions(spacer = "  ")
      deps = all_dependencies
      r = deps.reverse.map(&:factory_bot_let_definition)
      r << "let(:user){ FactoryBot.create(:user) }" unless deps.any?{|m| m.full_resource_name == 'user' }
      r.join("\n" << spacer)
    end

    def sample_value
      @sample_value ||= name.split('').map(&:ord).sum
    end
  end
end

require 'model_base'

module ModelBase
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:excluded_columns) do
      [
        /.*_checksum/,
        /.*_count/,
      ] + %w[_id _type id created_at updated_at]
    end

    config_accessor(:title_column_candidates) do
      ['name', 'title', 'email', 'display_name', 'display_title', /_name\z/, /_title\z/]
    end

  end
end

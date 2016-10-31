require 'model_base'

module ModelBase
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:home_dir){ ::Rails.root.join('.model_base').to_s }

    config_accessor(:disabled){ false }

    base_exclusions =
      [
        /.*_checksum/,
        /.*_count/,
      ] + %w[_id _type id]

    config_accessor(:excluded_columns_of_show) do
      base_exclusions
    end

    config_accessor(:excluded_columns_of_index) do
      base_exclusions + %w[updated_at]
    end

    config_accessor(:excluded_columns_of_form) do
      base_exclusions + %w[created_at updated_at]
    end

    config_accessor(:title_column_candidates) do
      ['name', 'title', 'email', 'display_name', 'display_title', /_name\z/, /_title\z/]
    end

    config_accessor(:skipped_files) do
      []
    end

    config_accessor(:base_time) do
      '2020-01-01 00:00:00'
    end

  end
end

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
  end
end

require 'rails/generators/base'

module ModelBase
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc "Generate files to work with model_base"

    def generate_files
      [
        'app/controllers/concerns/authentication.rb',
        'spec/factories/users.rb',
        'spec/support/controller_macros.rb',
        'spec/support/devise.rb',
        'spec/support/field_assertions.rb',
        'spec/support/time_match_support.rb',
      ].each{|f| template f, f }
    end
  end
end

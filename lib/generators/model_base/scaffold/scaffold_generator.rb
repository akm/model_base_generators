require 'model_base/generators/model_support'

module ModelBase
  module Generators
    class ScaffoldGenerator < ::Rails::Generators::NamedBase # :nodoc:
      include ::ModelBase::Generators::ModelSupport

      hook_for :controller, :views, default: true
    end
  end
end

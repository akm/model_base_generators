<%- unless ModelBase.config.frozen_string_literal.nil? -%>
# frozen_string_literal: <%= ModelBase.config.frozen_string_literal.inspect %>
<%- end -%>
# https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-(and-RSpec)
RSpec.configure do |config|
  [:controller, :view].each do |t|
    config.with_options(type: t) do |c|
      c.include Devise::Test::ControllerHelpers
      c.include ControllerMacros
      c.extend  ControllerMacros
    end
  end

  # For request spec
  # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
  # http://qiita.com/gakkie/items/40e5678af7b63afc14df
  config.include Warden::Test::Helpers, type: :request
  config.before :suite do
    Warden.test_mode!
  end
end

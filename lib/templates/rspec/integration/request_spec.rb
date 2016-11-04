<%- unless ModelBase.config.frozen_string_literal.nil? -%>
# frozen_string_literal: <%= ModelBase.config.frozen_string_literal.inspect %>
<%- end -%>
require 'rails_helper'

RSpec.describe '<%= class_name.pluralize %>', <%= type_metatag(:request) %> do
  let(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }

  describe 'GET /<%= table_name %>' do
    it 'works! (now write some real specs)' do
      get <%= index_helper %>_path
      expect(response).to have_http_status(200)
    end
  end
end

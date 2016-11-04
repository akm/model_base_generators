# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }

  describe 'GET /projects' do
    it 'works! (now write some real specs)' do
      get projects_path
      expect(response).to have_http_status(200)
    end
  end
end

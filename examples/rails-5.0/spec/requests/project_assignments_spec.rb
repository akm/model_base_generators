# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'ProjectAssignments', type: :request do
  let(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }

  describe 'GET /project_assignments' do
    it 'works! (now write some real specs)' do
      get project_assignments_path
      expect(response).to have_http_status(200)
    end
  end
end

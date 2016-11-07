# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'AttachedFiles', type: :request do
  let(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }

  describe 'GET /attached_files' do
    it 'works! (now write some real specs)' do
      get attached_files_path
      expect(response).to have_http_status(200)
    end
  end
end

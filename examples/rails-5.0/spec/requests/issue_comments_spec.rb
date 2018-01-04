# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'IssueComments', type: :request do
  let(:user) { FactoryBot.create(:user) }
  before { login_as(user, scope: :user) }

  describe 'GET /issue_comments' do
    it 'works! (now write some real specs)' do
      get issue_comments_path
      expect(response).to have_http_status(200)
    end
  end
end

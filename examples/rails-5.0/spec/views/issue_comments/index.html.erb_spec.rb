# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'issue_comments/index', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  let(:issue) { FactoryBot.create(:issue, project: project, creator: user) }
  before(:each) do
    assign(:issue_comments, [
             FactoryBot.create(:issue_comment, issue: issue, user: user, description: 'issue_comment_description_1'),
             FactoryBot.create(:issue_comment, issue: issue, user: user, description: 'issue_comment_description_2'),
           ])
  end

  it 'renders a list of issue_comments' do
    render
    assert_select 'tr>td', text: 'issue1', count: 2
    assert_select 'tr>td', text: 'user1@example.com', count: 2
    assert_select 'tr>td', text: 'issue_comment_description_1', count: 1
    assert_select 'tr>td', text: 'issue_comment_description_2', count: 1
  end
end

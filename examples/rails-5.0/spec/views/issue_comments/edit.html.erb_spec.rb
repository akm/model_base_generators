# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'issue_comments/edit', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  let(:issue) { FactoryBot.create(:issue, project: project, creator: user) }
  let(:issue_comment) { FactoryBot.create(:issue_comment, issue: issue, user: user) }
  before(:each) do
    assign(:issue_comment, issue_comment)
  end

  it 'renders the edit issue_comment form' do
    render

    assert_select 'form[action=?][method=?]', issue_comment_path(issue_comment), 'post' do
      assert_select 'input#issue_comment_id[name=?]', 'issue_comment[id]'
      assert_select 'select#issue_comment_issue_id[name=?]', 'issue_comment[issue_id]'
      assert_select 'select#issue_comment_user_id[name=?]', 'issue_comment[user_id]'
      assert_select 'textarea#issue_comment_description[name=?]', 'issue_comment[description]'
    end
  end
end

require 'rails_helper'

RSpec.describe 'issues/edit', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, owner: user) }
  before(:each) do
    @issue = assign(:issue, FactoryGirl.create(:issue, project: project, creator: user))
  end

  it 'renders the edit issue form' do
    render

    assert_select 'form[action=?][method=?]', issue_path(@issue), 'post' do
      assert_select 'select#issue_project_id[name=?]', 'issue[project_id]'
      assert_select 'input#issue_title[name=?]', 'issue[title]'
      assert_select 'select#issue_status[name=?]', 'issue[status]'
      assert_select 'select#issue_creator_id[name=?]', 'issue[creator_id]'
      assert_select 'select#issue_assignee_id[name=?]', 'issue[assignee_id]'
    end
  end
end

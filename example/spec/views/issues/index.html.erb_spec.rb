require 'rails_helper'

RSpec.describe 'issues/index', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, owner: user) }
  before(:each) do
    assign(:issues, [
             FactoryGirl.create(:issue, project: project, creator: user, title: 'issue1'),
             FactoryGirl.create(:issue, project: project, creator: user, title: 'issue2'),
           ])
  end

  it 'renders a list of issues' do
    render
    assert_select 'tr>td', text: 'project1', count: 2
    assert_select 'tr>td', text: 'issue1', count: 1
    assert_select 'tr>td', text: 'issue2', count: 1
    assert_select 'tr>td', text: 'Draft', count: 2
    assert_select 'tr>td', text: 'user1@example.com', count: 2
    assert_select 'tr>td', text: 'user1@example.com', count: 2
  end
end

require 'rails_helper'

RSpec.describe 'projects/index', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    assign(:projects, [
             FactoryGirl.create(:project, owner: user, name: 'project1'),
             FactoryGirl.create(:project, owner: user, name: 'project2'),
           ])
  end

  it 'renders a list of projects' do
    render
    assert_select 'tr>td', text: 'user1@example.com', count: 2
    assert_select 'tr>td', text: 'project1', count: 1
    assert_select 'tr>td', text: 'project2', count: 1
    assert_select 'tr>td', text: 'false', count: 2
  end
end

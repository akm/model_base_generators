require 'rails_helper'

RSpec.describe "project_assignments/index", type: :view do
  let(:project){ FactoryGirl.create(:project, owner: user) }
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    assign(:project_assignments, [
      FactoryGirl.create(:project_assignment, project: project, user: user),
      FactoryGirl.create(:project_assignment, project: project, user: user),
    ])
  end

  it "renders a list of project_assignments" do
    render
    assert_select "tr>td", :text => 'project1', :count => 2
    assert_select "tr>td", :text => 'user1@example.com', :count => 2
    assert_select "tr>td", :text => '2016-10-22 10:49:32', :count => 1
    assert_select "tr>td", :text => '2016-10-22 10:49:32', :count => 1
    assert_select "tr>td", :text => '2016-10-22 10:49:32', :count => 1
    assert_select "tr>td", :text => '2016-10-22 10:49:32', :count => 1
  end
end

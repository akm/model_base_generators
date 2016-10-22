require 'rails_helper'

RSpec.describe "projects/index", type: :view do
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    assign(:projects, [
      FactoryGirl.create(:project, name: 'project1', owner: user),
      FactoryGirl.create(:project, name: 'project2', owner: user),
    ])
  end

  it "renders a list of projects" do
    render
    assert_select "tr>td", :text => 'user1@example.com', :count => 2
    assert_select "tr>td", :text => 'project1', :count => 1
    assert_select "tr>td", :text => 'project2', :count => 1
    assert_select "tr>td", :text => 'false', :count => 2
  end
end

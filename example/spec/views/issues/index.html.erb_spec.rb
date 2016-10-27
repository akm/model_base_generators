require 'rails_helper'

RSpec.describe "issues/index", type: :view do
  let(:project){ FactoryGirl.create(:project, owner: user) }
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    assign(:issues, [
      FactoryGirl.create(:issue, title: 'issue1', project: project, creator: user),
      FactoryGirl.create(:issue, title: 'issue2', project: project, creator: user),
    ])
  end

  it "renders a list of issues" do
    render
    assert_select "tr>td", :text => 'project1', :count => 2
    assert_select "tr>td", :text => 'issue1', :count => 1
    assert_select "tr>td", :text => 'issue2', :count => 1
    assert_select "tr>td", :text => 'Draft', :count => 2
    assert_select "tr>td", :text => 'user1@example.com', :count => 2
    assert_select "tr>td", :text => 'user1@example.com', :count => 2
  end
end

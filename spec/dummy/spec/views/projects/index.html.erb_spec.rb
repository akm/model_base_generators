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
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end

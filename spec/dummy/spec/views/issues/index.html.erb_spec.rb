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
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end

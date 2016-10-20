require 'rails_helper'

RSpec.describe "issues/index", type: :view do
  before(:each) do
    assign(:issues, [
      FactoryGirl.create(:issue),
      FactoryGirl.create(:issue),
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

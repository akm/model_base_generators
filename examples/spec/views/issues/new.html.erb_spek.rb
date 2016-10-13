require 'rails_helper'

RSpec.describe "issues/new", type: :view do
  before(:each) do
    assign(:issue, FactoryGirl.build(:issue))
  end

  it "renders new issue form" do
    render

    assert_select "form[action=?][method=?]", issues_path, "post" do
    end
  end
end

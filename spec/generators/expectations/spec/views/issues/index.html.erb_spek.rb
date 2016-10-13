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
  end
end

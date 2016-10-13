require 'rails_helper'

RSpec.describe "spec/generators/index", type: :view do
  before(:each) do
    assign(:projects, [
      FactoryGirl.create(:spec_generator),
      FactoryGirl.create(:spec_generator),
    ])
  end

  it "renders a list of spec/generators" do
    render
  end
end

require 'rails_helper'

RSpec.describe "spec/generators/new", type: :view do
  before(:each) do
    assign(:spec_generator, FactoryGirl.build(:spec_generator))
  end

  it "renders new spec_generator form" do
    render

    assert_select "form[action=?][method=?]", issues_path, "post" do
    end
  end
end

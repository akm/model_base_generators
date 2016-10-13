require 'rails_helper'

RSpec.describe "spec/generators/edit", type: :view do
  before(:each) do
    @spec_generator = assign(:spec_generator, FactoryGirl.create(:spec_generator))
  end

  it "renders the edit spec_generator form" do
    render

    assert_select "form[action=?][method=?]", spec_generator_path(@spec_generator), "post" do
    end
  end
end

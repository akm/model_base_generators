require 'rails_helper'

RSpec.describe "spec/generators/show", type: :view do
  before(:each) do
    @spec_generator = assign(:spec_generator, FactoryGirl.create(:spec_generator))
  end

  it "renders attributes in <p>" do
    render
  end
end

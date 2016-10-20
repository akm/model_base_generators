require 'rails_helper'

RSpec.describe "issues/show", type: :view do
  before(:each) do
    @issue = assign(:issue, FactoryGirl.create(:issue))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end

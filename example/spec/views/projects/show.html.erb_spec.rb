require 'rails_helper'

RSpec.describe "projects/show", type: :view do
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    @project = assign(:project, FactoryGirl.create(:project, owner: user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/user1@example.com/)
    expect(rendered).to match(/project1/)
  end
end

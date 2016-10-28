require 'rails_helper'

RSpec.describe "issues/show", type: :view do
  let(:user){ FactoryGirl.create(:user) }
  let(:project){ FactoryGirl.create(:project, owner: user) }
  before(:each) do
    @issue = assign(:issue, FactoryGirl.create(:issue, project: project, creator: user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/project1/)
    expect(rendered).to match(/issue1/)
    expect(rendered).to match(/Draft/)
    expect(rendered).to match(/user1@example.com/)
    expect(rendered).to match(/user1@example.com/)
  end
end

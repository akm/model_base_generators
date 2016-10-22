require 'rails_helper'

RSpec.describe "project_assignments/show", type: :view do
  let(:project){ FactoryGirl.create(:project, owner: user) }
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    @project_assignment = assign(:project_assignment, FactoryGirl.create(:project_assignment, project: project, user: user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/project1/)
    expect(rendered).to match(/user1@example.com/)
    expect(rendered).to match(/2016-10-22 10:49:33/)
    expect(rendered).to match(/2016-10-22 10:49:33/)
  end
end

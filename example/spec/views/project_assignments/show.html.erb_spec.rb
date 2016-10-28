require 'rails_helper'

RSpec.describe "project_assignments/show", type: :view do
  let(:user){ FactoryGirl.create(:user) }
  let(:project){ FactoryGirl.create(:project, owner: user) }
  before(:each) do
    @project_assignment = assign(:project_assignment, FactoryGirl.create(:project_assignment, project: project, user: user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/project1/)
    expect(rendered).to match(/user1@example.com/)
    expect(rendered).to match(Regexp.new(Regexp.escape(localize(Time.zone.parse('2020-03-22 09:50:00 +09:00')))))
    expect(rendered).to match(Regexp.new(Regexp.escape(localize(Time.zone.parse('2020-03-22 23:40:00 +09:00')))))
  end
end

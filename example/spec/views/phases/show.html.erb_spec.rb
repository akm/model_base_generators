require 'rails_helper'

RSpec.describe "phases/show", type: :view do
  let(:project){ FactoryGirl.create(:project, owner: user) }
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    @phase = assign(:phase, FactoryGirl.create(:phase, project: project))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/project1/)
    expect(rendered).to match(/phase1/)
    expect(rendered).to match(Regexp.new(Regexp.escape(localize(Time.zone.parse('2020-01-29 02:50:00 +09:00')))))
    expect(rendered).to match(Regexp.new(Regexp.escape(localize(Time.zone.parse('2020-01-29 16:40:00 +09:00')))))
  end
end

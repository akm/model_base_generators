require 'rails_helper'

RSpec.describe "phases/index", type: :view do
  let(:user){ FactoryGirl.create(:user) }
  let(:project){ FactoryGirl.create(:project, owner: user) }
  before(:each) do
    assign(:phases, [
      FactoryGirl.create(:phase, name: 'phase1', project: project),
      FactoryGirl.create(:phase, name: 'phase2', project: project),
    ])
  end

  it "renders a list of phases" do
    render
    assert_select "tr>td", :text => 'project1', :count => 2
    assert_select "tr>td", :text => 'phase1', :count => 1
    assert_select "tr>td", :text => 'phase2', :count => 1
    assert_select "tr>td", :text => localize(Time.zone.parse('2020-01-29 02:50:00 +09:00')), :count => 2
    assert_select "tr>td", :text => localize(Time.zone.parse('2020-01-29 16:40:00 +09:00')), :count => 2
  end
end

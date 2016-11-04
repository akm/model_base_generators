# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'phases/show', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, owner: user) }
  let(:phase) { FactoryGirl.create(:phase, project: project) }
  before(:each) do
    assign(:phase, phase)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/project1/)
    expect(rendered).to match(/phase1/)
    expect(rendered).to match(localized_time_re('2020-01-29 02:50:00 +09:00'))
    expect(rendered).to match(localized_time_re('2020-01-29 16:40:00 +09:00'))
  end
end

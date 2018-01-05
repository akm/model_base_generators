# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'phases/index', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  before(:each) do
    assign(:phases, [
             FactoryBot.create(:phase, project: project, name: 'phase1'),
             FactoryBot.create(:phase, project: project, name: 'phase2'),
           ])
  end

  it 'renders a list of phases' do
    render
    assert_select 'tr>td', text: 'project1', count: 2
    assert_select 'tr>td', text: 'phase1', count: 1
    assert_select 'tr>td', text: 'phase2', count: 1
    assert_select 'tr>td', text: localize(Time.zone.parse('2020-01-29 02:50:00 +09:00')), count: 2
    assert_select 'tr>td', text: localize(Time.zone.parse('2020-01-29 16:40:00 +09:00')), count: 2
  end
end

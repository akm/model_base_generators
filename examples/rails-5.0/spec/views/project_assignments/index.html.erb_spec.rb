# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'project_assignments/index', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  before(:each) do
    assign(:project_assignments, [
             FactoryBot.create(:project_assignment, project: project, user: user),
             FactoryBot.create(:project_assignment, project: project, user: user),
           ])
  end

  it 'renders a list of project_assignments' do
    render
    assert_select 'tr>td', text: 'project1', count: 2
    assert_select 'tr>td', text: 'user1@example.com', count: 2
    assert_select 'tr>td', text: localize(Time.zone.parse('2020-03-22 09:50:00 +09:00')), count: 2
    assert_select 'tr>td', text: localize(Time.zone.parse('2020-03-22 23:40:00 +09:00')), count: 2
  end
end

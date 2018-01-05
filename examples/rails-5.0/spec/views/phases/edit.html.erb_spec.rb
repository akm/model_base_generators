# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'phases/edit', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  let(:phase) { FactoryBot.create(:phase, project: project) }
  before(:each) do
    assign(:phase, phase)
  end

  it 'renders the edit phase form' do
    render

    assert_select 'form[action=?][method=?]', phase_path(phase), 'post' do
      assert_select 'select#phase_project_id[name=?]', 'phase[project_id]'
      assert_select 'input#phase_name[name=?]', 'phase[name]'
      assert_select_datetime_field :phase, :started_at
      assert_select_datetime_field :phase, :finished_at
    end
  end
end

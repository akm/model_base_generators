# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'project_assignments/edit', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  let(:project_assignment) { FactoryBot.create(:project_assignment, project: project, user: user) }
  before(:each) do
    assign(:project_assignment, project_assignment)
  end

  it 'renders the edit project_assignment form' do
    render

    assert_select 'form[action=?][method=?]', project_assignment_path(project_assignment), 'post' do
      assert_select 'input#project_assignment_id[name=?]', 'project_assignment[id]'
      assert_select 'select#project_assignment_project_id[name=?]', 'project_assignment[project_id]'
      assert_select 'select#project_assignment_user_id[name=?]', 'project_assignment[user_id]'
      assert_select_datetime_field :project_assignment, :started_at
      assert_select_datetime_field :project_assignment, :finished_at
    end
  end
end

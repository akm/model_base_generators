require 'rails_helper'

RSpec.describe "project_assignments/new", type: :view do
  let(:project){ FactoryGirl.create(:project, owner: user) }
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    assign(:project_assignment, FactoryGirl.build(:project_assignment, project: project, user: user))
  end

  it "renders new project_assignment form" do
    render

    assert_select "form[action=?][method=?]", project_assignments_path, "post" do
      assert_select "input#project_assignment_id[name=?]", "project_assignment[id]"
      assert_select "select#project_assignment_project_id[name=?]", "project_assignment[project_id]"
      assert_select "select#project_assignment_user_id[name=?]", "project_assignment[user_id]"
      assert_select_datetime_field :project_assignment, :started_at
      assert_select_datetime_field :project_assignment, :finished_at
    end
  end
end

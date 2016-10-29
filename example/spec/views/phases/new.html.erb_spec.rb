require 'rails_helper'

RSpec.describe 'phases/new', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, owner: user) }
  let(:phase) { FactoryGirl.build(:phase, project: project) }
  before(:each) do
    assign(:phase, phase)
  end

  it 'renders new phase form' do
    render

    assert_select 'form[action=?][method=?]', phases_path, 'post' do
      assert_select 'select#phase_project_id[name=?]', 'phase[project_id]'
      assert_select 'input#phase_name[name=?]', 'phase[name]'
      assert_select_datetime_field :phase, :started_at
      assert_select_datetime_field :phase, :finished_at
    end
  end
end

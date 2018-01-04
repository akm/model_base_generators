# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'projects/new', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.build(:project, owner: user) }
  before(:each) do
    assign(:project, project)
  end

  it 'renders new project form' do
    render

    assert_select 'form[action=?][method=?]', projects_path, 'post' do
      assert_select 'select#project_owner_id[name=?]', 'project[owner_id]'
      assert_select 'input#project_name[name=?]', 'project[name]'
      assert_select 'input#project_closed[name=?]', 'project[closed]'
    end
  end
end

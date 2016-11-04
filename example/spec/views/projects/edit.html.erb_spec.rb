# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'projects/edit', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, owner: user) }
  before(:each) do
    assign(:project, project)
  end

  it 'renders the edit project form' do
    render

    assert_select 'form[action=?][method=?]', project_path(project), 'post' do
      assert_select 'select#project_owner_id[name=?]', 'project[owner_id]'
      assert_select 'input#project_name[name=?]', 'project[name]'
      assert_select 'input#project_closed[name=?]', 'project[closed]'
    end
  end
end

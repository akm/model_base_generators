require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    assign(:project, FactoryGirl.build(:project, owner: user))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do
      assert_select "select#project_owner_id[name=?]", "project[owner_id]"
      assert_select "input#project_name[name=?]", "project[name]"
    end
  end
end

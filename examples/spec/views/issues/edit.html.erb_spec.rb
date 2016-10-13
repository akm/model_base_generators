require 'rails_helper'

RSpec.describe "issues/edit", type: :view do
  before(:each) do
    @issue = assign(:issue, FactoryGirl.create(:issue))
  end

  it "renders the edit issue form" do
    render

    assert_select "form[action=?][method=?]", issue_path(@issue), "post" do
      assert_select "select#issue_project_id[name=?]", "issue[project_id]"
      assert_select "input#issue_title[name=?]", "issue[title]"
      assert_select "select#issue_status[name=?]", "issue[status]"
    end
  end
end

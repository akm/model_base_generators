require 'rails_helper'

RSpec.describe "issue_comments/new", type: :view do
  let(:user){ FactoryGirl.create(:user) }
  let(:project){ FactoryGirl.create(:project, owner: user) }
  let(:issue){ FactoryGirl.create(:issue, project: project, creator: user) }
  before(:each) do
    assign(:issue_comment, FactoryGirl.build(:issue_comment, issue: issue, user: user))
  end

  it "renders new issue_comment form" do
    render

    assert_select "form[action=?][method=?]", issue_comments_path, "post" do
      assert_select "input#issue_comment_id[name=?]", "issue_comment[id]"
      assert_select "select#issue_comment_issue_id[name=?]", "issue_comment[issue_id]"
      assert_select "select#issue_comment_user_id[name=?]", "issue_comment[user_id]"
      assert_select "textarea#issue_comment_description[name=?]", "issue_comment[description]"
    end
  end
end

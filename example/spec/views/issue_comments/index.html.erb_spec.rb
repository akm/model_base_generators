require 'rails_helper'

RSpec.describe "issue_comments/index", type: :view do
  let(:user){ FactoryGirl.create(:user) }
  let(:project){ FactoryGirl.create(:project, owner: user) }
  let(:issue){ FactoryGirl.create(:issue, project: project, creator: user) }
  before(:each) do
    assign(:issue_comments, [
      FactoryGirl.create(:issue_comment, issue: issue, user: user),
      FactoryGirl.create(:issue_comment, issue: issue, user: user),
    ])
  end

  it "renders a list of issue_comments" do
    render
    assert_select "tr>td", :text => 'issue1', :count => 2
    assert_select "tr>td", :text => 'user1@example.com', :count => 2
    assert_select "tr>td", :text => 'issue_comment_description_1', :count => 1
    assert_select "tr>td", :text => 'issue_comment_description_2', :count => 1
  end
end

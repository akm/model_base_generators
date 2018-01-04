# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'attached_files/new', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, owner: user) }
  let(:issue) { FactoryGirl.create(:issue, project: project, creator: user) }
  let(:issue_comment) { FactoryGirl.create(:issue_comment, issue: issue, user: user) }
  let(:attached_file) { FactoryGirl.build(:attached_file, issue_comment: issue_comment) }
  before(:each) do
    assign(:attached_file, attached_file)
  end

  it 'renders new attached_file form' do
    render

    assert_select 'form[action=?][method=?]', attached_files_path, 'post' do
      assert_select 'input#attached_file_id[name=?]', 'attached_file[id]'
      assert_select 'select#attached_file_issue_comment_id[name=?]', 'attached_file[issue_comment_id]'
      assert_select 'input#attached_file_url[name=?]', 'attached_file[url]'
    end
  end
end

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'attached_files/index', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  let(:issue) { FactoryBot.create(:issue, project: project, creator: user) }
  let(:issue_comment) { FactoryBot.create(:issue_comment, issue: issue, user: user) }
  before(:each) do
    assign(:attached_files, [
             FactoryBot.create(:attached_file, issue_comment: issue_comment, url: 'attached_file_url_1'),
             FactoryBot.create(:attached_file, issue_comment: issue_comment, url: 'attached_file_url_2'),
           ])
  end

  it 'renders a list of attached_files' do
    render
    assert_select 'tr>td', text: issue_comment.title, count: 2
    assert_select 'tr>td', text: 'attached_file_url_1', count: 1
    assert_select 'tr>td', text: 'attached_file_url_2', count: 1
  end
end

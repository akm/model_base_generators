# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'attached_files/index', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:issue) { FactoryGirl.create(:issue, project: project, creator: user) }
  let(:issue_comment) { FactoryGirl.create(:issue_comment, issue: issue, user: user) }
  before(:each) do
    assign(:attached_files, [
             FactoryGirl.create(:attached_file, issue_comment: issue_comment, url: 'attached_file_url_1'),
             FactoryGirl.create(:attached_file, issue_comment: issue_comment, url: 'attached_file_url_2'),
           ])
  end

  it 'renders a list of attached_files' do
    render
    assert_select 'tr>td', text: '1', count: 2
    assert_select 'tr>td', text: 'attached_file_url_1', count: 1
    assert_select 'tr>td', text: 'attached_file_url_2', count: 1
  end
end

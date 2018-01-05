# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'attached_files/show', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  let(:issue) { FactoryBot.create(:issue, project: project, creator: user) }
  let(:issue_comment) { FactoryBot.create(:issue_comment, issue: issue, user: user) }
  let(:attached_file) { FactoryBot.create(:attached_file, issue_comment: issue_comment) }
  before(:each) do
    assign(:attached_file, attached_file)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/attached_file_url_1/)
  end
end

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'issues/show', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  let(:issue) { FactoryBot.create(:issue, project: project, creator: user) }
  before(:each) do
    assign(:issue, issue)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/project1/)
    expect(rendered).to match(/issue1/)
    expect(rendered).to match(/Draft/)
    expect(rendered).to match(/user1@example.com/)
    expect(rendered).to match(/user1@example.com/)
  end
end

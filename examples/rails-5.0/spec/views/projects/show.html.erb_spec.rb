# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'projects/show', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, owner: user) }
  before(:each) do
    assign(:project, project)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/user1@example.com/)
    expect(rendered).to match(/project1/)
    expect(rendered).to match(/false/)
  end
end

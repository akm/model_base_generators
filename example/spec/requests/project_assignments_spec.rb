require 'rails_helper'

RSpec.describe "ProjectAssignments", type: :request do
  describe "GET /project_assignments" do
    it "works! (now write some real specs)" do
      get project_assignments_index_path
      expect(response).to have_http_status(200)
    end
  end
end

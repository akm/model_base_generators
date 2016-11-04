require 'rails_helper'

RSpec.describe "Phases", type: :request do
  describe "GET /phases" do
    it "works! (now write some real specs)" do
      get phases_index_path
      expect(response).to have_http_status(200)
    end
  end
end

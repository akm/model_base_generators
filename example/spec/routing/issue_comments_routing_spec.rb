require "rails_helper"

RSpec.describe IssueCommentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/issue_comments").to route_to("issue_comments#index")
    end

    it "routes to #new" do
      expect(:get => "/issue_comments/new").to route_to("issue_comments#new")
    end

    it "routes to #show" do
      expect(:get => "/issue_comments/1").to route_to("issue_comments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/issue_comments/1/edit").to route_to("issue_comments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/issue_comments").to route_to("issue_comments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/issue_comments/1").to route_to("issue_comments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/issue_comments/1").to route_to("issue_comments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/issue_comments/1").to route_to("issue_comments#destroy", :id => "1")
    end

  end
end

require "rails_helper"

RSpec.describe ProjectsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/spec/generators").to route_to("spec/generators#index")
    end

    it "routes to #new" do
      expect(:get => "/spec/generators/new").to route_to("spec/generators#new")
    end

    it "routes to #show" do
      expect(:get => "/spec/generators/1").to route_to("spec/generators#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/spec/generators/1/edit").to route_to("spec/generators#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/spec/generators").to route_to("spec/generators#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/spec/generators/1").to route_to("spec/generators#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/spec/generators/1").to route_to("spec/generators#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/spec/generators/1").to route_to("spec/generators#destroy", :id => "1")
    end

  end
end

require "rails_helper"

RSpec.describe PhasesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/phases").to route_to("phases#index")
    end

    it "routes to #new" do
      expect(:get => "/phases/new").to route_to("phases#new")
    end

    it "routes to #show" do
      expect(:get => "/phases/1").to route_to("phases#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/phases/1/edit").to route_to("phases#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/phases").to route_to("phases#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/phases/1").to route_to("phases#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/phases/1").to route_to("phases#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/phases/1").to route_to("phases#destroy", :id => "1")
    end

  end
end

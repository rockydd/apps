require "spec_helper"

describe FantuansController do
  describe "routing" do

    it "routes to #index" do
      get("/fantuans").should route_to("fantuans#index")
    end

    it "routes to #new" do
      get("/fantuans/new").should route_to("fantuans#new")
    end

    it "routes to #show" do
      get("/fantuans/1").should route_to("fantuans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fantuans/1/edit").should route_to("fantuans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fantuans").should route_to("fantuans#create")
    end

    it "routes to #update" do
      put("/fantuans/1").should route_to("fantuans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fantuans/1").should route_to("fantuans#destroy", :id => "1")
    end

  end
end

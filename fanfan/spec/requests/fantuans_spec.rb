require 'spec_helper'

describe "Fantuans" do
  describe "GET /fantuans" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get fantuans_path
      response.status.should be(200)
    end
  end
end

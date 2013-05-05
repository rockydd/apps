require 'spec_helper'

describe "fantuans/index" do
  before(:each) do
    assign(:fantuans, [
      stub_model(Fantuan,
        :name => "Name",
        :creator_id => 1
      ),
      stub_model(Fantuan,
        :name => "Name",
        :creator_id => 1
      )
    ])
  end

  it "renders a list of fantuans" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

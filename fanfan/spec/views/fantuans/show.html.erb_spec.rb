require 'spec_helper'

describe "fantuans/show" do
  before(:each) do
    @fantuan = assign(:fantuan, stub_model(Fantuan,
      :name => "Name",
      :creator_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end

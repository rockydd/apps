require 'spec_helper'

describe "fantuans/new" do
  before(:each) do
    assign(:fantuan, stub_model(Fantuan,
      :name => "MyString",
      :creator_id => 1
    ).as_new_record)
  end

  it "renders new fantuan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => fantuans_path, :method => "post" do
      assert_select "input#fantuan_name", :name => "fantuan[name]"
      assert_select "input#fantuan_creator_id", :name => "fantuan[creator_id]"
    end
  end
end

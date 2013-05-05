require 'spec_helper'

describe "fantuans/edit" do
  before(:each) do
    @fantuan = assign(:fantuan, stub_model(Fantuan,
      :name => "MyString",
      :creator_id => 1
    ))
  end

  it "renders the edit fantuan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => fantuans_path(@fantuan), :method => "post" do
      assert_select "input#fantuan_name", :name => "fantuan[name]"
      assert_select "input#fantuan_creator_id", :name => "fantuan[creator_id]"
    end
  end
end

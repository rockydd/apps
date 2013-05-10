require 'spec_helper'

describe Fantuan do
  it "has a valid factory" do
    FactoryGirl.create(:fantuan).should be_valid
  end
  
  it "is invalid without username" do
    FactoryGirl.build(:fantuan, name:nil).should_not be_valid
  end
end

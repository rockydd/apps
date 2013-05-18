require 'spec_helper'

describe Activity do
  it "has a valid factory" do
    FactoryGirl.create(:activity_with_payments).should be_valid
  end

  it "is invalid without needed field" do
    FactoryGirl.build(:activity, subject:nil).should_not be_valid
    FactoryGirl.build(:activity, occur_at:nil).should_not be_valid
    FactoryGirl.build(:activity, atype:nil).should_not be_valid
    FactoryGirl.build(:activity, cost:nil).should_not be_valid
    FactoryGirl.build(:activity, status:nil).should_not be_valid
  end

  context "validate activity is created" do
    before(:each) do
      @activity = FactoryGirl.create(:activity_with_payments)
    end

    it "should calculate user's balance correctly" do

    end
  end

end

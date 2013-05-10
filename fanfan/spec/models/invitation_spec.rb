require 'spec_helper'

describe Invitation do
  pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid factory" do
    FactoryGirl.create(:invitation).should be_valid
  end

  it "is invalid without necessary field" do
    FactoryGirl.build(:invitation, inviter_id:nil).should_not be_valid
    FactoryGirl.build(:invitation, invitee_id:nil).should_not be_valid
    FactoryGirl.build(:invitation, fantuan_id:nil).should_not be_valid
    FactoryGirl.build(:invitation, status:nil).should_not be_valid
  end
end


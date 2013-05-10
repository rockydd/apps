require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  
  it "is invalid without username" do
    FactoryGirl.build(:user, username:nil).should_not be_valid
  end

  it "is invalid without username3" do
    FactoryGirl.build(:user, username:nil).should_not be_valid
  end

  it "is invalid without username4" do
    FactoryGirl.build(:user, username:nil).should_not be_valid
  end

  it "can join a fantuan" do
    user = FactoryGirl.create(:user)
    fantuan = FactoryGirl.create(:fantuan)
    expect{
      user.join_fantuan(fantuan)
    }.to change(user.fantuans, :size).by(1) && change(fantuan.users, :size).by(1)
  end

end

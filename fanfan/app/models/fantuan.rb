class Fantuan < ActiveRecord::Base
  has_and_belongs_to_many :users, :order => "updated_at DESC"

  validates_presence_of :name


  def add_user(user)
    users << user unless users.include?(user)
    user.reload
    #user.fantuans << self unless user.fantuans.include?(self)
  end


  def update_balance

  end
end

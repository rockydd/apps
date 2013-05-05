class Fantuan < ActiveRecord::Base
  has_and_belongs_to_many :users, :order => "updated_at DESC"

  def add_user(user)
    users << user unless users.include?(user)
  end


  def update_balance

  end
end

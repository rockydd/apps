class Balance < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user, :amount
end

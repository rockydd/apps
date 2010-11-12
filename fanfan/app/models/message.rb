class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  has_many :message_items 
  validates :subject, :presence => true
end

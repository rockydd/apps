class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  validates :subject, :presence => true
  belongs_to :thread, :foreign_key => "thread_id", :class_name => "MessageThread"
end

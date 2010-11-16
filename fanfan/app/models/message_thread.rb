class MessageThread < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => "user_thread", :foreign_key => "threads_id", :association_foreign_key => "users_id"
  has_many :message
end

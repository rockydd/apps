class MessageThread < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => "inbox_threads", :foreign_key => "thread_id", :association_foreign_key => "user_id", :class_name => "User"
  has_many :messages, :foreign_key => "thread_id"

  cattr_reader :per_page
  @@per_page = 10

  def self.by_user(user_id, page) 
    paginate :conditions => ['inbox_threads.user_id =?', user_id],
             :joins      => 'INNER JOIN inbox_threads ON inbox_threads.thread_id = id',
             :order      => 'created_at DESC',
             :page       => page
  end

end

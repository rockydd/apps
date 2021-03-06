class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  has_many :activities, :through => :payments, :source => :activity
  has_many :payments
  has_many :messages, :foreign_key => 'receiver_id'
  has_and_belongs_to_many :threads, :join_table => "inbox_threads", :foreign_key => "user_id", :association_foreign_key => "thread_id", :class_name => "MessageThread", :order => "updated_at DESC"
  has_one :balance
  has_and_belongs_to_many :friends, :join_table => "user_relations", :foreign_key => "userid_from", :association_foreign_key=> "userid_to", :class_name => "User"

  attr_accessible :username, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end

  def self.find_by_username( name)
    user = find(:first, :conditions => ["lower(username) = ?", name.downcase ])
  end

  def self.find_by_email( email)
    user = find(:first, :conditions => ["lower(email) = ?", email.downcase ])
  end

  def self.list_by_asset
    users = User.all
    users.sort! {|x,y| y.asset <=> x.asset}
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  def is_creator_of?(activity)
    activity && activity.creator == self
  end

  def change_password(old_pass, new_pass)
    if matching_password?(old_pass)
      self.password = new_pass
      prepare_password
      return true
    end
    return false
  end	

  def total_payment
    payments.inject(0){|t, i| t = t + i.amount}
  end

  def User.total_payment
    User.all.inject(0){|t, u| t += u.total_payment}
  end

  def make_friends user
    friends << user unless friends.include?(user)
    user.friends << self unless user.friends.include?(self)
  end

  #all people I known, including myself
  def circle
    friends + [self]
  end

  def asset
    self.balance.nil? ? 0:self.balance.amount
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
end

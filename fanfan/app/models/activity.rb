class Activity < ActiveRecord::Base
  STATUS_NEW = "new"
  STATUS_CLOSED = "closed"
  
  has_many :payers, :through => :payments, :source => :user
  has_many :payments
  belongs_to :creator, :class_name => "User"
  validates_presence_of :subject
  validates_presence_of :status
  validates_presence_of :cost
  validates_presence_of :occur_at
  attr_accessible :subject, :status, :detail, :cost, :payers, :payments, :creator, :occur_at
  cattr_reader :per_page
  @@per_page = 10

  def payer_names
    return "" if payers.empty?
    return payers.map{|u| u.username}.join(",")
  end

  def balance_of_user(user)
    payment = payments.reject{ |p| p.user != user}[0]
    return 0 if payment.nil?
    average = cost/payments.size
    payment.amount - average
  end

  def confirmed_by_all?
    payments.reject{ |p| p.confirmed }.length.zero?
  end
  
  def payment_of_user(user)
    payments.find{|p| p.user == user}
  end

  def confirmed_by_user?(user)
    payment = payment_of_user(user)
    return payment && payment.confirmed
  end

  def closed?
    status == STATUS_CLOSED
  end

  def occur_date
    occur_at.to_s.split[0]
  end

  def self.paginate_by_user(user_id, page, all=true)
    if all
      paginate :conditions => ['payments.user_id = ?', user_id],
      :joins     => 'INNER JOIN payments ON payments.activity_id = activities.id',
      :order     => 'created_at DESC',
      :page      => page
    else
      paginate :conditions => ['payments.user_id = ? and status != ?', user_id, STATUS_CLOSED],
      :joins     => 'INNER JOIN payments ON payments.activity_id = activities.id',
      :order     => 'created_at DESC',
      :page      => page
    end
  end


end

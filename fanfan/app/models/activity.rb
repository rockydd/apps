class Activity < ActiveRecord::Base
  has_many :payers, :through => :payments, :source => :user
  has_many :payments
  belongs_to :creator, :class_name => "User"
  validates_presence_of :subject
  validates_presence_of :status
  validates_presence_of :cost
  validates_presence_of :occur_at
  attr_accessible :subject, :status, :detail, :cost, :payers, :payments, :creator, :occur_at


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
end

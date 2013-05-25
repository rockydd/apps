class PaymentsValidator < ActiveModel::Validator

  def validate(activity)
    if activity.payments.size <= 0
      activity.errors[:payments] << 'payments cannot be empty'
    end
    paid = activity.payments.inject(0.0) {|t,p| t += (p.amount || 0.0)}
    if ((activity.cost||0) - paid).abs > 0.000001
      activity.errors[:payments] << 'the total payment should be equal to the total cost.'
    end
    should_pay = activity.payments.inject(0.0) {|t,p| t += (p.should_pay || 0.0)}
    if ((activity.cost||0) - should_pay).abs > 0.000001
      activity.errors[:payments] << 'total should_pay should be equal to the total cost.'
    end
  end
end
    
class Activity < ActiveRecord::Base
  STATUS_NEW = "new"
  STATUS_CLOSED = "closed"
  TYPE_NORMAL = 0 #normal status
  TYPE_PAYBACK = 1 #type of payback, this will not be calculated as the total payment amount.
  
  has_many :payers, :through => :payments, :source => :user
  has_many :payments
  belongs_to :creator, :class_name => "User"
  validates_presence_of :subject
  validates_presence_of :status
  validates_presence_of :cost
  validates_presence_of :occur_at
  validates_associated  :payments
  validates :subject, :length => {:in => 2..300}
  validates :atype, :inclusion => {:in => [Activity::TYPE_NORMAL, Activity::TYPE_PAYBACK]}
  validates_with PaymentsValidator

  attr_accessible :subject, :status, :detail, :cost, :payers, :payments, :creator, :occur_at, :atype

  after_save :update_relation

  cattr_reader :per_page
  @@per_page = 10

  def payer_names
    return "" if payers.empty?
    return payers.map{|u| u.username}.join(",")
  end

  def balance_of_user(user)
    payment = payments.select{ |p| p.user == user}[0]
    return 0 if payment.nil?
    payment.amount - payment.should_pay
  end

  def confirmed_by_all?
    payments.reject{ |p| p.confirmed }.empty?
  end
  
  def payment_of_user(user)
    payments.find{|p| p.user == user}
  end

  def confirmed_by_user?(user)
    payment = payment_of_user(user)
    return payment && payment.confirmed
  end

  def max_payer
    payments.max_by{|p|p.amount}.user
  end

  def closed?
    status == STATUS_CLOSED
  end

  def occur_date
    occur_at.to_s.split[0]
  end

  def is_normal?
    atype == TYPE_NORMAL
  end
  
  def is_payback?
    atype == TYPE_PAYBACK
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

  def update_relation
    people = payers.to_a
    return if people.size<2
    (0..people.size-2).each do|i1|
      (1..people.size-1).each do|i2|
        people[i1].make_friends(people[i2])
      end
    end
  end

end

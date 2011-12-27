require 'message_sender'
require 'balance_lib'
class ActivitiesController < ApplicationController
  before_filter :login_required
  before_filter :merge_occur_time, :only => [:create, :update]
  include MessageSender
  include BalanceLib

  def index
    @activities = Activity.paginate_by_user(current_user.id, params[:page])

    respond_to do |format|
      format.html
      format.xml { params[:from] == "jqgrid" ? (render :action => "list.rxml") : (render :xml => @activities)}
    end
  end

  def show
    @activity = Activity.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @activity}
    end
  end

  def new
    @activity = Activity.new
    @users = User.find(:all)
  end

  def create
    #usernames = params[:activity].delete(:user_names).split(",")
    #users = usernames.map{|n| User.find_by_name(n)}
    #params[:activity][:users] = users
    params[:activity][:payments] = get_payments

    @activity = Activity.new(params[:activity])
    @activity.creator = current_user

    @activity.status='new'
    if @activity.save
      flash[:notice] = "Successfully created activity."
      send_confirmation_message(@activity)
      redirect_to @activity
    else
      @users=User.find(:all)
      render :action => 'new'
    end
  end

  def edit
    @activity = Activity.find(params[:id])
    @users = User.find(:all)
  end

  def update
    @activity = Activity.find(params[:id])

    params[:activity][:payments] = get_payments
    if @activity.update_attributes(params[:activity])
      flash[:notice] = "Successfully updated activity."
      redirect_to @activity
    else
      render :action => 'edit'
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    flash[:notice] = "Successfully destroyed activity."
    redirect_to activities_url
  end

  def confirm_payment
    activity = Activity.find(params[:id])
    if activity.nil?
      @confirmed = false
      @error_message = "activity not found"
      render :layout => false
      return
    end

    user = current_user
    if ! activity.payers.include?(user)
      @confirmed = false
      @error_message = "you didn't attend this activity"
      render :layout => false
      return
    end

    payment = activity.payments.find(:first, :conditions => "user_id = #{user.id}")
    payment.confirmed = true
    payment.save
    @confirmed = true

    if activity.confirmed_by_all?
      calculate_balance(activity)
      activity.status = "confirmed"
      activity.save!
    end

    render :layout => false
  end

  private
  def get_payments
    payments = []
    begin
      pay_hash = Hash[*params[:activity][:payments]]
      pay_hash.keys.each do |username|
        user = User.find_by_username(username)
        payment = Payment.new(:user_id => user.id.to_i, :amount => pay_hash[username])
        payments << payment
      end
      return payments
    rescue Exception => e
      return nil
    end

    payments = params[:activity][:payments].inject([]){|r,i| r[-1].is_a?(String) ?  r<<(Payment.new(:user_id => r.pop().to_i, :amount => i, :confirmed => false)) : r<<i}
    return payments if payments.size <= 1
    total = payments[0].amount
    average = payments[0].amount/payments.size

    #other payed
    other_total = payments[1..-1].inject(0){ |sum,i| sum += i.amount}
    payments[0].amount = total - other_total

    payments
  end

  CONFIRMATION_MESSAGE="There is a new activity need your confirmation, please click following link to get there:\n\n <a href='/activities/__ID__'>ACTIVITY_NAME</a>"
  def send_confirmation_message(activity)
    body = CONFIRMATION_MESSAGE.sub('__ID__', activity.id.to_s)
    body.sub!('ACTIVITY_NAME',activity.subject)
    send_message(activity.creator,@activity.payers, "Need your confirmation for #{activity.subject}", body)
    #UserMailer.activity_email(user, @activity)
    
  end

  def merge_occur_time
    params[:activity][:occur_at] = params[:activity][:occur_at] + " " + params[:activity][:occur_at_time]
  end

end

require 'message_sender'
require 'balance'
class ActivitiesController < ApplicationController
  before_filter :login_required
  include MessageSender
  include BalanceLib

  def index
    @rows = (params[:rows]||10).to_i
    @page = (params[:page]||1).to_i
    @sort = params[:sord]||'desc'
    @sidx = params[:sidx]||'id'

    if params[:_search] == 'true'
      field = params[:searchField]
      value = params[:searchString]
      oper  = { "eq" => "=","lt" => "<"}[params[:searchOper]]||'like'
      conditions = "#{field} #{oper} '#{value}'"
    end
    @activities = current_user.activities
    @total = Activity.count
    if conditions
      @activities = @activities.find(:all,:limit => @rows,:offset => @rows*(@page.to_i-1),:order => "#{@sidx} #{@sort}", conditions.nil? ? nil:conditions => [conditions] )
    else
      #fixme, is this necessary?
      @activities = @activities.find(:all,:limit => @rows,:offset => @rows*(@page.to_i-1),:order => "#{@sidx} #{@sort}" )
    end

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
    end

    render :layout => false
  end

  private
  def get_payments
    payments = []
    begin
      pay_hash = Hash[*params[:activity][:payments]]

      pay_hash.keys.each do |user_id|
        payment = Payment.new(:user_id => user_id.to_i, :amount => pay_hash[user_id])
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

  CONFIRMATION_MESSAGE="There is a new activity need your confirmation, please click following link to get there:\n\n <a href='/activities/'"
  def send_confirmation_message(activity)
      send_message(activity.creator,@activity.payers, "Need your confirmation for #{activity.subject}", CONFIRMATION_MESSAGE+activity.id.to_s)
  end

end

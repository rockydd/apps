require 'message_sender'
require 'balance_lib'
require 'tools'
class ActivitiesController < ApplicationController
  before_filter :login_required, :except => [:check_activities]
  #around_filter :activity_validation_exception, :only => [:create, :update]
  before_filter :merge_occur_time, :only => [:create, :update]
  before_filter :process_payments, :only => [:create, :update]
  include MessageSender
  include BalanceLib
  include Tools

  def index

    @activities = Activity.paginate_by_user(current_user.id, params[:page], params[:all])

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
    @activity.creator = current_user
    @users = User.find(:all)
  end

  def create
    params[:activity][:atype] ||= 0
    @activity = Activity.new(params[:activity])
    if @payments_invalid
      @users = User.find(:all)
      render :action => 'new'
      return
    end
    @activity.creator = current_user

    @activity.status='new'
    if @activity.save
      flash[:notice] = "Successfully created activity."
      my_payment = @activity.payments.find{|p| p.user == current_user}
      if my_payment
        my_payment.confirmed = true 
        my_payment.save 
      end
      # fixme, temperory comment before configure mail correctly
      send_confirmation_message(@activity)
      redirect_to @activity
    else
      @users=User.find(:all)
      render :action => 'new'
    end
  end

  def edit
    @activity = Activity.find(params[:id])
    if @activity.closed? 
      flash[:error] = "You can not edit closed activity"
      redirect_to :action => 'index'
    end
    if @activity.payments.find{|p| p.user == current_user}.nil?
      flash[:error] = "You are not in that activity"
      redirect_to :action => 'index'
    end
    @users = User.find(:all)
  end

  def update

    @activity = Activity.find(params[:id])
    if @payments_invalid
      @users = User.find(:all)
      render :action => 'edit'
      return
    end
    
    #delete the old payments first
    @activity.payments.each {|p| p.destroy}
    if @activity.update_attributes(params[:activity])
      flash[:notice] = "Successfully updated activity."
      my_payment = @activity.payments.find{|p| p.user == current_user}
      if my_payment
        my_payment.confirmed = true 
        my_payment.save 
      end
      send_confirmation_edited_message(@activity)
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
      activity.status = Activity::STATUS_CLOSED
      activity.save!
    end

    render :layout => false
  end

  #this action is for cron job. it will check the confirmation status. will send email
  #to who didn't concfirm the trasactions.
  def check_activities
    unconfirmed_activities = Activity.where(["status != 'closed'"])
    unconfirmed_activities.each do |activity|
      activity.payments.select{|p| !p.confirmed}.each do|payment|
        UserMailer.activity_email(payment.user, activity).deliver
        logger.info("sent mail to #{payment.user.username}")
      end
    end
    head :ok
  end

  private
  def process_payments
    @payments = []
    @payments_invalid = false
    payments = params.select{|p| p =~ /payments_[0-9]+/}
    payments.each_value do |p|
      username = p[:name]
      user = User.find_by_username(username)
      if(user.nil?)
        flash.now[:error] = "user #{username} not found"
        @payments_invalid = true
        next
      end
      payment = Payment.new(:user_id => user.id.to_i, :amount => p[:amount], :should_pay => p[:should_pay])
      @payments << payment
    end

    if @payments.size <= 0
      flash.now[:error] = "Need at least one participant."
      @payments_invalid = true
    end
    params[:activity][:payments] = @payments 
  end

  CONFIRMATION_MESSAGE="There is a new activity need your confirmation, please click following link to get there:\n\n <a href='/activities/__ID__'>ACTIVITY_NAME</a>"

  CONFIRMATION_EDIT_MESSAGE="There is a changed activity need your confirmation, please click following link to get there:\n\n <a href='/activities/__ID__'>ACTIVITY_NAME</a>"

  def send_confirmation_message(activity)
    body = CONFIRMATION_MESSAGE.sub('__ID__', activity.id.to_s)
    body.sub!('ACTIVITY_NAME',activity.subject)
    send_message(activity.creator,@activity.payers, "Need your confirmation for #{activity.subject}", body)
    fork {
      @activity.payers.each do |user|
        if user != current_user
          UserMailer.activity_email(user, @activity).deliver
        end
      end
    }
  end

  def send_confirmation_edited_message(activity)
    body = CONFIRMATION_EDIT_MESSAGE.sub('__ID__', activity.id.to_s)
    body.sub!('ACTIVITY_NAME',activity.subject)
    send_message(activity.creator,@activity.payers, "Need your confirmation for #{activity.subject}", body)
    fork {
      @activity.payers.each do |user|
        if user != current_user
          UserMailer.edit_activity_email(user, @activity).deliver
        end
      end
    }
  end

  def merge_occur_time
    if params[:activity][:occur_at].nil? || params[:activity][:occur_at_time].nil?
      params[:activity][:occur_at] = Time.now.to_s
    else
      params[:activity][:occur_at] = params[:activity][:occur_at] + " " + params[:activity][:occur_at_time]
    end
  end

  def activity_validation_exception
    begin
      yield
    rescue Exception => e
      debugger
      @activity = Activity.new(params[:activity])
      logger.info(e.message)
      flash[:error] = e.message
      render :action => :new
    end
  end

end

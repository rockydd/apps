class MessagesController < ApplicationController
  before_filter :login_required
  # GET /messages
  # GET /messages.xml
  def index
    @threads = MessageThread.by_user(current_user.id, params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @threads }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
    @users = User.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  def reply
    @message = Meessage.new(params[:new_message])
    @message.sent_date = Time.new
    @message.sender = current_user 
    #@message.thread = MessageThread.find(params[:thread_id]) 
    @message.save
    redirect_to :controller => "thread", :action => "show", :id => @message.thread
  end 
  
  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    @message.sent_date = Time.new
    @message.sender = current_user

    @thread = MessageThread.new() 
    @thread.title = @message.subject
    @thread.status = "new"
    
    @message.thread = @thread
    
    current_user.threads << @thread
    if current_user != @message.receiver
      @message.receiver.threads << @thread
    end

    begin
      MessageThread.transaction do
        @thread.save!
        @message.save!
      end
      respond_to do |format|
        format.html { redirect_to(:action => "index") }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      end 
    rescue ActiveRecord::RecordInvalid => invalid
	respond_to do |format|
	    format.html { render :action => "new" }
	    format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
	end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(@message, :notice => 'Message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end

  def reply
    @message = Message.find(params[:id])
    @message
  end
end

class ThreadController < ApplicationController
  def show
    @thread = MessageThread.find(params[:id])
    @messages = @thread.messages
    @new_message = Message.new
  end

  def reply
    @message = Message.new(params[:message])
    @message.sent_date = Time.new
    @message.sender = current_user 
    @message.thread = MessageThread.find(params[:id]) 
    @message.subject = @message.thread.title
    @message.save!
    redirect_to :controller => "thread", :action => "show", :id => @message.thread
  end 
end

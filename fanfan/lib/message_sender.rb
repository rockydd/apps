module MessageSender
  def send_message(sender, receivers, title, content)

    receivers = receivers.to_a
    thread = MessageThread.new
    thread.title = title
    thread.status = "new"
    thread.users << sender

    receivers.delete(sender)

    receivers.each do |receiver|
        thread.users << receiver
    end

    sender.threads << thread
    receivers.each do |receiver|
      receiver.threads << thread
    end

    message = Message.new
    message.subject = title
    message.body = content
    message.sent_date = Time.new
    message.sender = sender

    message.thread = thread

    begin
      MessageThread.transaction do
        thread.save!
        message.save!
      end
    rescue ActiveRecord::RecordInvalid => invalid
      return false
    end
    return true
  end
end

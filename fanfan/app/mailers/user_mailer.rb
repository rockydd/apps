class UserMailer < ActionMailer::Base
  default :from => "no-reply@emc.com"

  def activity_email(user, activity)
    @user = user
    @activity = activity
    mail(:to => user.email, :subject => t("mail.subject.new_activity"))
  end
  
  def edit_activity_email(user,activity)
    @user = user
    @activity = activity
    mail(:to => user.email, :subject => t("mail.subject.edit_activity"))
  end
end

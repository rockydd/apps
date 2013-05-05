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

  #user   to be invited
  #fantuan  to be join
  #inviter  user send the invitation
  def fantuan_invitation(user, fantuan, inviter)
    @user = user
    @inviter = inviter
    @fantuan = fantuan
    mail(:to => user.email, :subject => t("mail.subject.fantuan_invitation"))

  end
end

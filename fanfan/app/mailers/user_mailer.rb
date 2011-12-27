class UserMailer < ActionMailer::Base
  default from: "rocky.dong@emc.com"

  def activity_email(user, activity)
    @user = user
    @activity = activity

    mail(:to => user.email, :subject => "New activity need your confirmation")

  end
end

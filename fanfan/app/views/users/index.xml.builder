xml.instruct!
xml.UserList do
  @users.each do |user|
    xml.User do
      xml.UserId(user.username)
    end
  end
end

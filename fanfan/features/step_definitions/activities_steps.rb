Given /system has (.*) users/ do |num|
  @users = FactoryGirl.create_list(:user,5)
end
  
Given /a user (.*) login/ do |username|
  rocky = FactoryGirl.create(:user, :username => username, :password => '123456')
  visit '/login/'
  fill_in 'login', :with => username
  fill_in 'password', :with => '123456'
  click_link 'log in'
end

When /I create a new activity (.*) which cost (.*) with (.*) members/ do |act_name, cost, member_num|
  visit activities_path
  click_link 'New Activity'
  fill_in 'Subject', :with => act_name
  fill_in 'cost', :with => cost
  click_link 'create'

end

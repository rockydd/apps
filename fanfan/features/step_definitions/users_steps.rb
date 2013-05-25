Given /system is ready to register/ do
  #nothing need to do
end

When /I sign up with name ([^ ]+) and password (.+)$/ do |name, password|
  @username, @password = [name,password]

  visit '/signup/'
  fill_in 'Username', :with => name
  fill_in 'user_password', :with => password
  fill_in 'user_password_confirmation', :with => password
  #fill_in 'Confirm Password', :with => password
  fill_in 'Email Address', :with => "#{name}@fanfan.com"

  click_button  'Sign up'
  page.should have_content ("Welcome")
end

Then /I should be able to login to the system as ([^ ]+) with password ([^ ]+)$/ do |username, password|
  visit '/login/'
  fill_in 'login', :with => username
  fill_in 'password', :with => password
  click_button'Log in'
  page.should have_content("Welcome #{username}")
  #page.has_contain?("welcome #{@username}")

end

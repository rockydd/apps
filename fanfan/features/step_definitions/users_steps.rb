Given /system is ready/ do
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

When /I visit singup page/ do
  visit '/signup/'
end

And /fill (.+) as the username/ do |username|
  fill_in 'Username', :with => username
end

And /fill (.+) as the email address/ do |email|
  fill_in 'Email Address', :with => email
end

And /fill (.+) as the password/ do |password|
  fill_in 'Password', :with => password
end

And /fill (.+) as the confirm password/ do |password|
  fill_in 'Confirm Password', :with => password
end

And /click button (.+)$/ do |button|
  click_button button
end

Then /I should see (.+)$/ do |text|
  page.should have_content(text)
end


#complete step for signing up
Given /signed up a user (.+) with password (.+)$/ do |username, password|
  visit '/signup'
  step "fill #{username} as the username"
  step "fill #{username}@gmail.com as the email address"
  step "fill #{password} as the password"
  step "fill #{password} as the confirm password"
  step "click button Sign up"
end

When /I visit login page/ do
  visit '/login/'
end

Given /logged in as (.+)$/ do |username|
  password='123456'
  visit '/login'
  step "fill #{username} as the username"
  step "fill #{password} as the password"
  step "click button Log in"
end

Given /^the following people exist$/ do |table|
  # table is a Cucumber::Ast::Table
  
  table.hashes.each do |t|
    step "signed up a user #{t[:name]} with password 123456"
  end
end

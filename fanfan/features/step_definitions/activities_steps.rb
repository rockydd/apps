
When /I create a new activity (.*) which cost (.*) with (.*) members/ do |act_name, cost, member_num|
  visit activities_path
  click_link 'New Activity'
  fill_in 'activity_subject', :with => act_name
  fill_in 'Cost', :with => cost
  (1..4).each do|c|
    click_link 'add participant'
    fill_in "payername#{c+1}", :with => @users[c]
  end
  click_button 'Save'
end

Then /The average payment should be (.+)$/ do |num|
  page.should have_content "Successfully"
  page.should have_content "Average Cost: #{num}"
end

And /the total cost should be (.+)$/ do |num|
  page.should have_content "Total cost: #{num}"
end

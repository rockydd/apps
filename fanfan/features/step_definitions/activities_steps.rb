
When /I create a activity (.*) which cost (.*) with (.*) members/ do |act_name, cost, member_num|
  visit activities_path
  click_link 'New Activity'
  fill_in 'activity_subject', :with => act_name
  fill_in 'Cost', :with => cost
  member_num = member_num.to_i
  (1..member_num-1).each do|c|
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

And /the subject should be (.+)$/ do |sub|
  page.should have_content "#{sub}"
end

When /^I create an activity (.+) which cost (\d+) and has following payment$/ do |subject, cost, payments|
  # table is a Cucumber::Ast::Table
  visit activities_path
  click_link 'New Activity'
  fill_in 'activity_subject', :with => subject
  fill_in 'Cost', :with => cost
  payments.hashes.each_with_index do |p, i|
    unless i.zero?
      click_link 'add participant'
      fill_in "payername#{i+1}", :with => p['Participant']
      fill_in "payments_#{i+1}[amount]", :with => p['Paid']
    end
    fill_in "payments_#{i+1}[should_pay]", :with => p['Should Pay']
  end
  click_button 'Save'
end

Then /the payments detail should be/ do |payments|
  payments.hashes.each_with_index do |p, i|
    page.should have_selector(:xpath, "//table/tbody[2]/tr[#{i+1}]/td[1]", :text => p['Participant'])
    page.should have_selector(:xpath, "//table/tbody[2]/tr[#{i+1}]/td[2]", :text => p['Paid'])
    page.should have_selector(:xpath, "//table/tbody[2]/tr[#{i+1}]/td[3]", :text => p['Should Pay'])
    page.should have_selector(:xpath, "//table/tbody[2]/tr[#{i+1}]/td[4]", :text => p['Balance'])
    page.should have_selector(:xpath, "//table/tbody[2]/tr[#{i+1}]/td[5]", :text => p['Status'])
  end
end

When /^I visit activity (.+)$/ do |link|
  visit activities_path
  click_link link
end

When /^I click Confirm$/ do
  click_link 'Confirm'
end

Then /(.+) should has (.*)confirmed/ do |user, sta|
  sta.strip! unless sta.nil?
  page.should have_selector(".#{user}_action", :text => sta == 'not' ? "Not confirmed" : "Confirmed")
end

Then /(.+) should has Confirm link/ do |user|
  page.should have_selector(".#{user}_action", :text=> "Confirm")
end

##Balances##

Given (/^following people confirmed activity (.+)$/) do |acts, table|
  # table is a Cucumber::Ast::Table
  acts.split(",").each do |act|
    table.hashes.each do |row|
      name=row['name']
      step "logged in as #{name}"
      step "I visit activity #{act}"
      if page.has_no_selector?(".#{name}_action", :text => "Confirmed")
        step "I click Confirm"
      end
    end
  end
end

Then (/^the balance detail should be$/) do |table|
  # table is a Cucumber::Ast::Table
  visit balances_path
  table.hashes.each do |row|
    name = row['name']
    balance = row['balance']
    page.should have_selector(".#{name}_balance", :text => balance)
  end
end

Then /a user should only see her friend in balance page/ do |table|
  table.hashes.each do |row|
    login_user = row['login_user']
    friends = row['friends']
    non_friends = row['non friends']
    step "logged in as #{login_user}"
    visit balances_path
    friends.split(",").each do |f|
      page.should have_selector(".#{f}_balance")
    end
    non_friends.split(",").each do |n|
      page.should_not have_selector(".#{n}_balance")
    end
  end
end

When(/^I fill (.+) as (.+)$/) do |value, field|
  fill_in field, :with => value
end

When(/^click button (.+)$/) do |button|
  click_button button
end

Then /I should see (.+)$/ do |text|
  page.should have_content(text)
end



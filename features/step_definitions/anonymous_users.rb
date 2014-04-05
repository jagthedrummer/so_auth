Given(/^an anonymous user$/) do
  # do nothing
end

When(/^he visits "(.*?)"$/) do |arg1|
  visit arg1
end

Then /^he should see "(.*?)"$/ do |text|
  page.should have_content(text)
end

Then(/^he should be redirected into the oauth dance$/) do
  page.should have_content "If this wasn't an integration test, you'd be redirected to:"
  page.should have_content "/auth/so_auth?origin=http://www.example.com/stuff/private"
end


Given(/^I am on the ([^"]*)$/) do |page|
  case page
    when 'home page'
      visit '/'
  end
end

And(/^I click on "([^"]*)"$/) do |element|
  click_link_or_button element
end

Then(/^I should be on the "([^"]*)" page$/) do |page|
  case page
    when 'Register'
      expect(current_path).to eq '/auth/register'
  end
end

And(/^I fill in "([^"]*)" with "([^"]*)"$/) do |element, value|
  fill_in(element, with: value)
end

Then(/^show me the page$/) do
  save_and_open_page
end

And(/^I should see "([^"]*)"$/) do |string|
  expect(page).to have_text string
end
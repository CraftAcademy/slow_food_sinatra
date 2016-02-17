Given(/^I am registerd as visitor$/) do
  user = User.create(username: 'Visitor',
                     password: 'password',
                     password_confirmation: 'password',
                     email: 'visitor@random.com',
                     phone_number: '12345667',
                     admin: false)
  login_as user
end

Given(/^I am registerd and logged out admin$/) do
  steps '
    Given I am registerd as admin
    And I am on the home page
    And I click on "Log_Out"
    Then I should be on the "home" page
    And I should see "Successfully logged out"
  '
end

Given(/^I am registerd as admin$/) do
  user = User.create(username: 'Admin',
                     password: 'password',
                     password_confirmation: 'password',
                     admin: true
                    )
  login_as user
end

Given(/^I am registerd and logged out visitor$/) do
  steps '
    Given I am registerd as visitor
    And I am on the home page
    And I click on "Log_Out"
    Then I should be on the "home" page
    And I should see "Successfully logged out"
  '
end

Given(/^I am logged in as Visitor$/) do
  steps '
    And I am on the home page
    And I click on "Log_In"
    Then I should be on the "login" page
    And I fill in "user[username]" with "Visitor"
    And I fill in "user[password]" with "password"
    And I click on "Log In"
    Then I should be on the "home" page
    And I should see "Successfully logged in Visitor"
    '
end

Given(/^the following categories exists$/) do |table|
  table.hashes.each do |hash|
    Category.create!(hash)
  end
end

Given(/^the following users exists$/) do |table|
  table.hashes.each do |hash|
    user = User.new(username: hash[:username],
                    password: hash[:password],
                    password_confirmation: hash[:password_confirmation],
                    admin: hash[:admin],
                    email: hash[:email],
                    phone_number: hash[:phone_number]
                   )
    user.save
  end
end

Given(/^the following dishes exists$/) do |table|
  table.hashes.each do |hash|
    category = Category.first(name: hash[:category])
    user = User.first(username: hash[:user])
    # binding.pry
    dish = Dish.new(name: hash[:name], price: hash[:price].to_i, category: category, user: user)
    dish.save
  end
end

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
  when 'Register Admin'
    expect(current_path).to eq '/auth/admin/register'
  when 'login'
    expect(current_path).to eq '/auth/login'
  when 'Menu'
    expect(current_path).to eq '/menu'
  when 'home page'
    expect(current_path).to eq '/'
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

And(/^there are no dishes in the system$/) do
  Dish.all.each(&:destroy)
end


And(/^I select "([^"]*)" from "([^"]*)"$/) do |option, field|
  select option, from: field
end

And(/^I fill in "([^"]*)" with "([^"]*)" for "([^"]*)"$/) do |element, value, dish|
within("#{dish.id}") do
#within("//li[@id='dish']") do
  #within(option, visible: false) do
#within('dish', :visible => false) do
fill_in(element, with: value)
end
end

And(/^I click on "([^"]*)" for "([^"]*)"$/) do |element, dish|
 #binding.pry
  within("#{dish.id}") do
  #expect(page).to have_text dish
#binding.pry
  #within(expect(page).to have_text dish) do
  click_link_or_button element
  end
end

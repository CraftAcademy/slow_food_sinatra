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
    And I click on "Log Out"
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

Given(/^I am registerd and logged out as "([^"]*)"$/) do |name|
  steps %(
    Given I am registerd as #{name}
    And I am on the home page
    And I click on "Log Out"
  )
end

Given(/^I am logged in as "([^"]*)"$/) do |name|
  visitor = User.first(username: name)
  login_as visitor
end

Given(/^I am not registerd at all$/) do
  User.all.each(&:destroy)
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
  when 'Add Dish page'
    visit '/menu/add_dish'
  end
end

Given(/^Two "([^"]*)" added to my basket already$/) do |arg1|
  steps '
     Given I am logged in as "Visitor"
     And I am on the home page
     And I click on "Menu"
     Then I should be on the "Menu" page
     Then I should see "Fries"
     And I fill in "basket_item[qty]" with "2" for "Fries"
     And I click on "Add to basket" for "Fries"
     Then I should see "Fries added to your basket"
'
end

Given(/^I finalized my order$/) do
   steps '
   Given  Two "Fries" added to my basket already
   And I click on "View Basket"
   Then I should be on the "check out" page
   And I should see "2 Dishes of Fries, price per each: 35kr"
   And The time now is "2016-02-22 18:00:00 +0100"
   And I click on "Finalize Order"
   Then I should see "Thank you for placing your order with total of 70 kr your order expected to be ready for pickup at 2016-02-22 18:30:00 +0100 Enjoy your meal Visitor"
   '
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
  when 'Add Dish'
    expect(current_path).to eq '/menu/add_dish'
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
  d = Dish.first(name: dish)
  within("##{d.id}") do
    fill_in(element, with: value)
  end
end

And(/^I click on "([^"]*)" for "([^"]*)"$/) do |element, dish|
  d = Dish.first(name: dish)
  within("##{d.id}") do
    click_link_or_button element
  end
end

Then(/^I should not see "([^"]*)"$/) do |string|
  page.should have_no_text string
end

Then(/^The time now is "([^"]*)"$/) do |time|
 Timecop.freeze Time.parse(time)
end

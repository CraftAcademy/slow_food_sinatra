Feature: As visitor or Admin,
  - As admin:
  - Should create admin account by providing only username & password
  - As visitor:
  - should require to have username, password and adress
  _ As visitor or admin:
  - Should be able to log in
  - Should be able to log out

  Scenario: Register a User : admin
    Given I am registerd as admin
    And I am on the home page
    And I click on "Register Admin"
    Then I should be on the "Register Admin" page
    And I fill in "Username" with "admin"
    And I fill in "Password" with "admin"
    And I fill in "Password Confirmation" with "admin"
    And I click on "Create account"
    Then I should be on the "home" page
    And I should see "Successfully created account for admin"

  Scenario: Register a User : visitor
    Given I am on the home page
    And I click on "Register"
    Then I should be on the "Register" page
    And I fill in "Username" with "user"
    And I fill in "Password" with "user"
    And I fill in "Password Confirmation" with "user"
    And I fill in "Email" with "visitor@me.com"
    And I fill in "Phone Number" with "0988002626"
    And I click on "Create account"
    Then I should be on the "home" page
    And I should see "Successfully created account for user"

  Scenario: Register a User : visitor with password not matching
    Given I am on the home page
    And I click on "Register"
    Then I should be on the "Register" page
    And I fill in "Username" with "user"
    And I fill in "Password" with "user"
    And I fill in "Password Confirmation" with "user_2"
    And I fill in "Email" with "visitor@me.com"
    And I fill in "Phone Number" with "0988002626"
    And I click on "Create account"
    Then I should be on the "home" page
    And I should see "Password not matching confirmation"

  Scenario: Register a User : visitor without email
    Given I am on the home page
    And I click on "Register"
    Then I should be on the "Register" page
    And I fill in "Username" with "user"
    And I fill in "Password" with "user"
    And I fill in "Password Confirmation" with "user"
    And I fill in "Email" with ""
    And I fill in "Phone Number" with "0988002626"
    And I click on "Create account"
    Then I should be on the "home" page
    And I should see "Please add email adress"

  Scenario: Register a User : visitor without valid email
    Given I am on the home page
    And I click on "Register"
    Then I should be on the "Register" page
    And I fill in "Username" with "user"
    And I fill in "Password" with "user"
    And I fill in "Password Confirmation" with "user"
    And I fill in "Email" with "werwonvwur"
    And I fill in "Phone Number" with "0988002626"
    And I click on "Create account"
    Then I should be on the "home" page
    And I should see "Doesn't look like an email address to me ..."

  Scenario: Register a User : visitor without phone number
    Given I am on the home page
    And I click on "Register"
    Then I should be on the "Register" page
    And I fill in "Username" with "user"
    And I fill in "Password" with "user"
    And I fill in "Password Confirmation" with "user"
    And I fill in "Email" with "visitor@me.com"
    And I fill in "Phone Number" with ""
    And I click on "Create account"
    Then I should be on the "home" page
    And I should see "Please provide phone number"

  Scenario: Log out : Visitor
    Given I am registerd as visitor
    And I am on the home page
    And I click on "Log Out"
    Then I should be on the "home" page
    And I should see "Successfully logged out"

  Scenario: Log out : Admin
    Given I am registerd as admin
    And I am on the home page
    And I click on "Log Out"
    Then I should be on the "home" page
    And I should see "Successfully logged out"

  Scenario: Log in : Visitor
    Given I am registerd and logged out as "visitor"
    And I click on "Log In"
    Then I should be on the "login" page
    And I fill in "user[username]" with "Visitor"
    And I fill in "user[password]" with "password"
    And I click on "Log In"
    Then I should be on the "home" page
    And I should see "Successfully logged in Visitor"

  Scenario: Log in : Admin
    Given I am registerd and logged out admin
    And I click on "Log In"
    Then I should be on the "login" page
    And I fill in "user[username]" with "Admin"
    And I fill in "user[password]" with "password"
    And I click on "Log In"
    Then I should be on the "home" page
    And I should see "Successfully logged in Admin"

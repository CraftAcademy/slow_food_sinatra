Feature: As a restuarnt owner
  In order to have selection of dishes in menu for visitors to order from
  i want to access protected part of the applicaiton and add information about :
  resturant
  dishes offered: in 3 be it Starter , Main Course  , Dessert
  dish price

  Background:
    Given the following users exists
      | username | password | password_confirmation | admin | email | phone_number |
      | Mazen | same | same | true | mine@any.com | 028756778 |
      | Thomas | shme | shme | true | youe@any.com | 098756678 |
      | Rich | saje | saje | false | addr@any.com | 098734778 |
    Given the following categories exists
      | name |
      | Starter |
      | Main Course |
      | Dessert |
    Given the following dishes exists
      | name | category | price | user |
      | Salad | Starter | 30 | Mazen |
      | Soup | Starter | 40 | Mazen |
      | Fries | Starter | 35 | Mazen |
      | Pasta | Main Course | 90 | Mazen |
      | Pizza | Main Course | 85 | Thomas |
      | Kebab | Main Course | 110 | Thomas |
      | Cake | Dessert | 50 | Thomas |
      | Fruit | Dessert | 60 | Thomas |
      | IceCream | Dessert | 75 | Mazen |

  Scenario: list menu items before storing dishes
    Given I am registerd as admin
    And there are no dishes in the system
    And I am on the home page
    Then I should be on the "home" page
    And I click on "Menu"
    Then I should be on the "menu" page
    And I should see "You dont have any dishes yet"

  Scenario: menu visible for : admin
    Given I am registerd as admin
    And I am on the home page
    Then I should be on the "home" page
    And I click on "Menu"
    Then I should be on the "menu" page
    And I should see "Salad"
    And I should see "30"
    And I should see "Soup"
    And I should see "40"

  Scenario: menu visible for : visitor
    Given I am registerd as visitor
    And I am on the home page
    Then I should be on the "home" page
    And I click on "Menu"
    Then I should be on the "menu" page
    And I should see "Salad"
    And I should see "30"
    And I should see "Soup"
    And I should see "40"

  Scenario: menu visible for : non registered
    Given I am on the home page
    Then I should be on the "home" page
    And I click on "Menu"
    Then I should be on the "menu" page
    And I should see "Salad"
    And I should see "30"
    And I should see "Soup"
    And I should see "40"

  Scenario: Add a dish as admin
    Given I am registerd as admin
    And I am on the home page
    And I click on "Menu"
    Then I should be on the "Menu" page
    And I click on "Add Dish"
    And I fill in "dish_name" with "Bread"
    And I fill in "Price" with "50"
    And I select "Starter" from "dish_category"
    And I click on "Add"
    Then I should be on the "menu" page
    And I should see "Successfully added Bread"

  Scenario: Add a dish as visitor
    Given I am registerd as visitor
    And I am on the home page
    And I click on "Menu"
    Then I should be on the "Menu" page
    Then I should not see "Add Dish"


 Scenario: Add a dish as visitor even when am at the page
    Given I am registerd as visitor
    And I am on the Add Dish page
    Then I should be on the "Add Dish" page
    And I should see "Please, enjoy ordering and leave dish creation to our Chef!"

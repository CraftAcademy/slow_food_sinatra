Feature: As a restuarnt visitor
  In order to make my order i should be able to :
  - add dishes to my basket
  - add quantity ordered
  - non registerd not to be able to add dishes to basket

  Background:
    Given the following users exists
      | username | password | password_confirmation | admin | email              | phone_number |
      | Mazen    | same     | same                  | true  | mine@any.com       | 028756778    |
      | Thomas   | shme     | shme                  | true  | youe@any.com       | 098756678    |
      | Rich     | saje     | saje                  | false | addr@any.com       | 098734778    |
      | Fat      | qwer     | qwer                  | false | qwer@ew.com        | 098765456    |
      | Visitor  | password | password              | false | visitor@random.com | 12345667     |
    Given the following categories exists
      | name        |
      | Starter     |
      | Main Course |
      | Dessert     |
    Given the following dishes exists
      | name     | category    | price | user   |
      | Salad    | Starter     | 30    | Mazen  |
      | Soup     | Starter     | 40    | Mazen  |
      | Fries    | Starter     | 35    | Mazen  |
      | Pasta    | Main Course | 90    | Mazen  |
      | Pizza    | Main Course | 85    | Thomas |
      | Kebab    | Main Course | 110   | Thomas |
      | Cake     | Dessert     | 50    | Thomas |
      | Fruit    | Dessert     | 60    | Thomas |
      | IceCream | Dessert     | 75    | Mazen  |

  Scenario: Add dish to basket
    Given I am logged in as "Visitor"
    And I am on the home page
    And I click on "Menu"
    Then I should be on the "Menu" page
    Then I should see "Fries"
    And I fill in "basket_item[qty]" with "2" for "Fries"
    And I click on "Add to basket" for "Fries"
    Then I should see "Fries added to your basket"

  Scenario: Add dish to basket without being logged in
    Given I am not registerd at all
    And I am on the home page
    And I click on "Menu"
    Then I should be on the "Menu" page
    Then I should see "Fries"
    Then I should not see "Add to basket"
    Then I should see "Please log in to enjoy ordering!"

  Scenario: View basket not to be visible for admin
    Given I am registerd as admin
    And I am on the home page
    And I click on "Menu"
    Then I should be on the "Menu" page
    Then I should not see "View Basket"

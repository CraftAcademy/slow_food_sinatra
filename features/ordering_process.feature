Feature: As a visitor to the resturant website
  In order to make my order, i should be able to :
  - see mneu including : dish / categoru  / price
  - add dishes to my order
  - see total order price
  - see expected time to pick up

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


 Scenario: View ordered dishes
    Given  Two "Fries" added to my basket already
    And I click on "View Basket"
    Then I should be on the "check out" page
    And I should see "2 Dishes of Fries, price per each: 35kr"



 Scenario: order finalization
    Given  Two "Fries" added to my basket already
    And I click on "View Basket"
    Then I should be on the "check out" page
    And I should see "2 Dishes of Fries, price per each: 35kr"
    And The time now is "2016-02-22 18:00:00 +0100"
    And I click on "Finalize Order"
    Then I should see "Thank you for placing your order with total of 70 kr your order expected to be ready for pickup at 2016-02-22 18:30:00 +0100 Enjoy your meal Visitor"

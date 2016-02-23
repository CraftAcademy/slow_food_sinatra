### SlowFood (Sinatra)

NOTE: the following application is an assignment developed as part of challenges during Craft Academy coding bootcamp /http://craftacademy.se/, a 12-week program aiming to build coding skills in 12 weeks using real cases/ challenges in a mix of classes, assignment and personal coaching approach.

The case: Our client is a Restaurant owner that needs an website where he can list his menu and allow visitors to view menu and place orders.

#### Scope (v1)

The first version of the application has limited functionality

* The owner need to access a protected part of the application to set up information about his Restaurant and his Menu
* Menu needs to consist of many Dishes
* Each Dish is a Starter, Main course or Dessert
* Visitors of the site can add Dishes to an Order
* Order need to calculate a Total price and a Pick up time (30 minutes)

Nothing else should be considered or implemented.

#### Tools
* Sinatra as web framework
* Foundation6 as CSS framework
* PostgreSQL for database
* Warden for user authentication
* Cucumber for acceptance tests
RSPec for unit tests

V1 outcome:

application developed, and the code attached is capable of doing the following :

* Pre-assigned administrator: hardcoded username /Admin/ , password /password/ with authority to : register other admins
* Log in portal, with encryption functionality and multiple unhappy routs (email format / phone number length/ password confirmation/ duplicate usernames) :
  - for admin, it require username/ password  
  - for visitor, it require username/ password/ phone number/ email   
  - log out function
* Add dish functionality that visible and accessible by admins only, dishes categories preassigned as: Starter/ Main Course/ Desert
* Menu of dishes categorized by dish categories, visible for everyone (registered and non registered users)
* Ability to add dishes to basket along with quantity, visible and accessible for registered visitors only (not visible for admins), with multi unhappy routs
* Basket functionality showing selected dishes / price per each and total order value in Swedish krone (no calculation for VAT added) with unhappy rout developed (zero quantity)
* Ability to finalize order by :
  - Either cancel order and return to menu
  - Finalize order , which lead to thank you page showing : total value / buyer name / expected pick up time hardcoded to be 30 min from order finalizing time
* All above functionalities has related tests written in cucumber, available in features folder



Tips :
* to use the application, You have to visit data_mapper.erb and change the Posgres admin name to match the one you use on your machine (default is Postgres)
* Multiple get/post request cant be done in one module, for basket.erb solution was to include js button functionality
* Adding foundation on Sinatra application: css / js folders has to be placed in folder “public” in order to be accessed by layout.er

Feature: User management

  So that I can signup and singin
  As a user
  I want to login and use the system 

  Scenario: signup a new user and login
    Given system is ready
    When I sign up with name rocky and password 123456
    Then I should be able to login to the system as rocky with password 123456

  @signup
  Scenario: signup a new user
    Given system is ready
    When I visit singup page
    And fill Rocky as the username
    And fill rockydd@gmail.com as the email address
    And fill 123456 as the password
    And fill 123456 as the confirm password
    And click button Sign up
    Then I should see Welcome Rocky

  @signin
  Scenario: sign in as an existing user
    Given signed up a user Rocky with password 123456
    When I visit login page
    And fill Rocky as the username
    And fill 123456 as the password
    And click button Log in
    Then I should see Welcome Rocky



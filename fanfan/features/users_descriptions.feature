Feature: User management

  So that I can signup and singin
  As a user
  I want to login and use the system 


  @signup
  Scenario: signup a new user
    Given system is ready
    When I visit singup page
    And fill rockydd as the username
    And fill rockydd@gmail.com as the email address
    And fill 123456 as the password
    And fill 123456 as the confirm password
    And click button Sign up
    Then I should see Welcome rockydd

  @signin
  Scenario: sign in as an existing user
    Given signed up a user rocky with password 123456
    When I visit login page
    And fill rocky as the username
    And fill 123456 as the password
    And click button Log in
    Then I should see Welcome rocky

  @test
  Scenario: single step for sign in
    Given the following people exist
      |name|
      |dgf|
      |rockydd|
    When I logged in as dgf
    Then I should see Welcome dgf
    When I logged in as rockydd
    Then I should see Welcome rockydd


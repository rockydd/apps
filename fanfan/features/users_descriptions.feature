@wip
Feature: User management

  So that I can signup and singin
  As a user
  I want to login and use the system 

  Scenario: signup a new user and login
    Given system is ready to register
    When I sign up with name rocky and password 123456
    Then I should be able to login to the system


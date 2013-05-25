@wip
Feature: Activity Creation

  So that I can create a activity
  As a activity creator
  I want to see the new acitvity with correct balance

  Background: logged in
    Given logged in as rocky
    And the following people exist
      |name|
      |shawn|
      |mario|
      |dux|
      |edward|
      |everett|
      |terry|
  Scenario: Activity for average payment
    When I create a new activity familymart which cost 200 with 5 members
    Then The average payment should be 40
    And the total cost should be 200


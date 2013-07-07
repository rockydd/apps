Feature: Manage my fantuan

  So that I can manage my fantuan
  As a fanfan user
  I want to create list update and delete my fantuan

  Background: user exists
    Given the following people exist
      |name|
      |rocky|
      |shawn|
      |mario|
      |dux|
      |edward|
      |everett|
      |terry|
      |sheaon|
      |edwin|
  @javascript @wip
  Scenario: Create a new fantuan
    When I logged in as rocky
    And I go to fantuan page
    And I click Add Fantuan
    And I fill fanfanbang as Fantuan Name
    And I press Save
    Then I should see fanfanbang created

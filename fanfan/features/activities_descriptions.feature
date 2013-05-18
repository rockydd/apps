Feature: Activity Creation

  So that I can create a activity
  As a activity creator
  I want to see the new acitvity with correct balance

  Scenario: Activity for average payment
    Given an average activity
    When I create a new activity which cost 200 with 4 members
    Then The average payment should be 50:w
    



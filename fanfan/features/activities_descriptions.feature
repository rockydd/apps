Feature: Activity Creation

  So that I can create a activity
  As a activity creator
  I want to see the new acitvity with correct balance

  Background: logged in
    Given the following people exist
      |name|
      |rocky|
      |shawn|
      |mario|
      |dux|
      |edward|
      |everett|
      |terry|
  @javascript
  Scenario: Create activity of average payment
    When logged in as rocky
    And I create a activity familymart which cost 200 with 5 members
    Then The average payment should be 40
    And the total cost should be 200
    And the subject should be familymart
    And the payments detail should be
      |Participant|Paid     |Should Pay     |Balance      |Status|
      |rocky      |￥200.00 |￥40.00        |￥160.00    |Confirmed|
      |shawn      |￥0.00   |￥40.00        |￥-40.00    |Not confirmed|
      |mario      |￥0.00   |￥40.00        |￥-40.00    |Not confirmed|
      |dux        |￥0.00   |￥40.00        |￥-40.00    |Not confirmed|
      |edward     |￥0.00   |￥40.00        |￥-40.00    |Not confirmed|

  @javascript @wip
  Scenario: Create an activity which has different paid and should pay
    When logged in as rocky
    And I create an activity luosen which cost 200 and has following payment
      |Participant|Paid   |Should Pay|
      |rocky      |130    |30        |
      |shawn      |50     |70        |
      |mario      |20     |80        |
      |dux        |0      |20        |
    Then the payments detail should be
      |Participant|Paid     |Should Pay     |Balance      |Status|
      |rocky      |￥130.00 |￥30.00        |￥100.00    |Confirmed|
      |shawn      |￥50.00  |￥70.00        |￥-20.00    |Not confirmed|
      |mario      |￥20.00  |￥80.00        |￥-60.00    |Not confirmed|
      |dux        |￥0.00   |￥20.00        |￥-20.00    |Not confirmed|

  @javascript
  Scenario: Confirm activities
    When logged in as rocky
    And I create a activity familymart which cost 200 with 5 members
    And I logged in as shawn
    And I visit activity familymart
    Then mario should has not confirmed
    And shawn should has Confirm link
    And I click Confirm
    Then shawn should has confirmed




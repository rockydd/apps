Feature: Checking balance

  So that I can check the balnace of mine and my friends
  As a user of fanfan
  I can know who should pay next

  Background: have many people in system
    Given the following people exist
      |name|
      |rocky|
      |shawn|
      |mario|
      |dux|
      |edward|
      |everett|
      |terry|
      |tony|
      |Alex|
      |ChengCheng|
  @javascript @wip
  Scenario: Participate and confirm activities
    Given logged in as rocky
    And I create an activity luosen which cost 200 and has following payment
      |Participant|Paid   |Should Pay|
      |rocky      |130    |30        |
      |shawn      |50     |70        |
      |mario      |20     |80        |
      |dux        |0      |20        |
    And I create an activity familymart which cost 200 and has following payment
      |Participant|Paid   |Should Pay|
      |rocky      |130    |70        |
      |shawn      |50     |30        |
      |mario      |20     |20        |
      |dux        |0      |80        |
    And following people confirmed activity luosen,familymart
      |name|
      |rocky|
      |shawn|
      |mario|
      |dux|
    Then the balance detail should be
      |name   |balance     |
      |rocky  |￥160.00    |
      |shawn  |￥0.00      |
      |mario  |￥-60.00    |
      |dux    |￥-100.00   |

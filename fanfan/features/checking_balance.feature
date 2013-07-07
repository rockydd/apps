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
      |alex|
      |chengcheng|
  @javascript
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

  @javascript
  Scenario: Only show my friends balance by default
    Given logged in as rocky
    And I create an activity luosen which cost 200 and has following payment
      |Participant|Paid   |Should Pay|
      |rocky      |130    |30        |
      |shawn      |50     |70        |
      |mario      |20     |80        |
      |dux        |0      |20        |
    And following people confirmed activity luosen
      |name|
      |rocky|
      |shawn|
      |mario|
      |dux|
    And logged in as tony
    And I create an activity familymart which cost 90 and has following payment
      |Participant|Paid   |Should Pay|
      |tony       |90     |30        |
      |alex       |0      |30        |
      |chengcheng |0      |30        |
    And following people confirmed activity familymart
      |name|
      |tony|
      |alex|
      |chengcheng|
    Then a user should only see her friend in balance page
      |login_user |friends        |non friends        |
      |rocky      |rocky,shawn,dux|tony,alex,chengcheng|
      |tony       |alex,chengcheng|rocky,shawn,dux     |

    Scenario: Calculate the balance only in his fantuan.

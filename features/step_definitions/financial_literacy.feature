Feature: Financial Literacy Tips
  In order to improve my financial skills
  As a new user of the budget app
  I want to receive financial literacy tips

  @budgeting_tips
  Scenario: Financial Literacy Tips
    Given I am new to budgeting
    When I use the app
    Then I should see helpful financial literacy tips
    And I should be able to access additional resources on budgeting

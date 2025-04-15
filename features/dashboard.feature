Feature: Financial Dashboard Overview
  In order to get a quick snapshot of my finances
  As a user of the budget app
  I want a dashboard that shows my income, expenses, and available balance

  @monthly_overview
  Scenario: Monthly Overview
    Given I am managing my budget for the current month
    When I view my financial dashboard
    Then I should see an overview of my total income, expenses, and remaining balance for the month

  @visual_feedback
  Scenario: Visual Feedback
    Given I want to see my financial status at a glance
    When I open the dashboard
    Then I should see a summary of my income, expenses, and remaining balance
    And the display should include graphs or charts for visual aid
    And I should be able to navigate easily to detailed sections

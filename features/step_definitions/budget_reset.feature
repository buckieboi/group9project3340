Feature: Monthly Budget Reset
  In order to begin a new budgeting period
  As a user of the budget app
  I want to reset my budget at the start of each month

  @budget_reset
  Scenario: Budget Reset
    Given a new month has started
    When I choose to reset my budget
    Then my old transactions should be archived
    And I should start with a clean slate for the new month
    And any recurring expenses should automatically be re-added if applicable

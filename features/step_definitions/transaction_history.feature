Feature: Transaction History and Reporting
  In order to review my financial decisions
  As a user of the app
  I want to view and filter my past transactions

  @view_history
  Scenario: Transaction Memory
    Given I have made multiple transactions
    When I return to the app
    Then I should be able to view all my past exchanges
    And each transaction's details should be accurate

  @search_filter
  Scenario: History Tracking
    Given I want to review a specific period or type of transaction
    When I use the filter or search functionality
    Then I should see only the relevant transactions
    And the filtered results should update in real time

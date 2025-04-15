Feature: Subscription Management
  In order to effectively manage recurring expenses
  As a budget app user
  I want to add, update, or remove my subscriptions

  @add_remove_subscription
  Scenario: Subscription Management
    Given I have a Netflix subscription
    When I add or remove it from my expenses in the app
    Then my monthly budget should update accordingly
    And the change should be reflected immediately in my expense list

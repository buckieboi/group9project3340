Feature: Transactions Management
  In order to keep track of my finances accurately
  As a user of the budget app
  I want to record and modify my transactions

  @withdrawal
  Scenario: Concert Withdrawal
    Given I have money in my budget
    When I pull out money for a concert
    Then my available balance should decrease
    And I should see a record of the withdrawal

  @overdraft
  Scenario: Overdraft Alert
    Given I am withdrawing money
    When I attempt to withdraw more than my available balance
    Then I should receive a warning about overdraft risk
    And I should be prompted to confirm or cancel the transaction

  @income
  Scenario: Job Income Addition
    Given I have earned money from my job
    When I add my income to the app
    Then my total balance should increase
    And I should see the income reflected in my transaction history

  @edit_delete
  Scenario: Editing/Deleting Transactions
    Given I have recorded a transaction
    When I choose to edit the transaction details
    Then I should be able to update the amount and description
    And my budget should update accordingly

  @delete_transaction
  Scenario: Deleting a Transaction
    Given I have a transaction recorded that was added in error
    When I choose to delete the transaction
    Then the transaction should be removed from my history
    And my balance should adjust to reflect this removal

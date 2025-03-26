Scenario: Concert Withdrawal
Given I have money in my budget,
When I pull out money for a concert,
Then my available balance should decrease,
And I should see a record of the withdrawal.

Scenario: Overdraft Alert
Given I am withdrawing money,
When I attempt to withdraw too much,
Then I should receive a warning,
And I should be prompted to confirm or cancel the transaction.

Scenario: Job Income Addition
Given I have earned money from my job,
When I add my income to the app,
Then my total balance should increase,
And I should see the income reflected in my transaction history.

Scenario: Transaction Memory
Given I have made past transactions,
When I return to the app,
Then I should be able to view all my past exchanges,
And the details should be accurate.

Scenario: History Tracking
Given I want to review my finances,
When I check my transaction history,
Then I should see a list of all my past transactions,
And I should be able to filter or search through them.

Scenario: Monthly Overview
Given I am managing my budget,
When I view my financial dashboard,
Then I should see an overview of my income, expenses, and remaining balance for the current month.

Scenario: Subscription Management
Given I have a Netflix subscription,
When I add or remove it from my expenses,
Then my monthly budget should update accordingly,
And I should see the change reflected in my expense list.

Scenario: Financial Literacy Tips
Given I am new to budgeting,
When I use the app,
Then I should see financial literacy tips,
And I should be able to learn how to improve my budgeting skills.

Scenario: Secure Login
Given I have an account,
When I enter my credentials,
Then I should be logged in securely,
And my financial data should be accessible only to me.

Scenario: Budget Reset
Given a new month has started,
When I reset my budget,
Then my old transactions should be archived,
And I should start with a fresh budget for the month.

Scenario: Editing/Deleting Transactions
Given I have recorded a transaction,
When I need to correct an entry,
Then I should be able to edit or delete it,
And my budget should update accordingly.

Scenario: Visual Feedback (Dashboard)
Given I want to see my financial status at a glance,
When I open the dashboard,
Then I should see a summary of my income, expenses, and remaining balance,
And I should be able to navigate easily.
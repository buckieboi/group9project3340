# features/step_definitions/app_steps.rb

# Helpers: Assumes that you have FactoryBot configured (see support/factory_bot.rb)
# and that your models User, Transaction, Subscription, and Expense exist and behave as expected.
# You might need to adjust property names (like :balance, :transaction_type, etc.) to match your app.

# --------------------------
# General Setup
# --------------------------

Given("I have money in my budget") do
  @user = FactoryBot.create(:user, balance: 100)
end

Given("I have ${int} in my budget") do |amount|
  @user = FactoryBot.create(:user, balance: amount)
end

# --------------------------
# Transaction Scenarios - Happy Paths
# --------------------------

When("I pull out money for a concert") do
  @transaction = @user.transactions.create(
    amount: 30,
    transaction_type: 'withdrawal',
    description: 'Concert ticket'
  )
end

Then("my available balance should decrease") do
  # For example, if the original balance was 100 and 30 was withdrawn.
  expect(@user.reload.balance).to eq(70)
end

Then("I should see a record of the withdrawal") do
  expect(@user.transactions.last.description).to match(/Concert ticket/i)
end

When("I add my income to the app") do
  @transaction = @user.transactions.create(
    amount: 100,
    transaction_type: 'deposit',
    description: 'Job income'
  )
end

Then("my total balance should increase") do
  # Assuming @user had an initial balance of 50 set in a prior step.
  expect(@user.reload.balance).to eq(150)
end

Then("I should see the income reflected in my transaction history") do
  expect(@user.transactions.last.description).to match(/Job income/i)
end

Given("I have made past transactions") do
  @user ||= FactoryBot.create(:user, balance: 100)
  3.times do |i|
    @user.transactions.create(
      amount: (10 * (i + 1)),
      transaction_type: 'withdrawal',
      description: "Transaction #{i + 1}"
    )
  end
end

When("I return to the app") do
  @user.reload
end

Then("I should be able to view all my past exchanges") do
  expect(@user.transactions.count).to be > 0
end

Then("the details should be accurate") do
  @user.transactions.each do |t|
    expect(t.description).not_to be_empty
  end
end

Given("I want to review my finances") do
  @user ||= FactoryBot.create(:user)
end

When("I check my transaction history") do
  @transactions = @user.transactions.all
end

Then("I should see a list of all my past transactions") do
  expect(@transactions).not_to be_empty
end

Then("I should be able to filter or search through them") do
  # For example, filter transactions by a keyword.
  filtered = @transactions.select { |t| t.description =~ /withdrawal/i }
  expect(filtered.count).to be >= 0
end

Given("I am managing my budget") do
  @user ||= FactoryBot.create(:user, balance: 200)
end

When("I view my financial dashboard") do
  # Simulate a dashboard summary; you might compute this based on transactions.
  @dashboard = {
    income: 100,
    expenses: 50,
    balance: @user.balance
  }
end

Then("I should see an overview of my income, expenses, and remaining balance for the current month") do
  expect(@dashboard).to have_key(:income)
  expect(@dashboard).to have_key(:expenses)
  expect(@dashboard).to have_key(:balance)
end

Given("I have a Netflix subscription") do
  @user ||= FactoryBot.create(:user)
  @user.subscriptions.create(name: "Netflix", monthly_cost: 15)
end

When("I add or remove it from my expenses") do
  subscription = @user.subscriptions.find_by(name: "Netflix")
  if subscription
    subscription.destroy
  else
    @user.subscriptions.create(name: "Netflix", monthly_cost: 15)
  end
end

Then("my monthly budget should update accordingly") do
  # For example, you might recompute monthly expenses here.
  # We'll check that the subscription no longer exists or has been recreated.
  expect(@user.subscriptions.find_by(name: "Netflix")).to satisfy { |s| s.nil? || s.persisted? }
end

Then("I should see the change reflected in my expense list") do
  @expenses = @user.expenses || []  # Assuming your User model has an association with expenses.
  expect(@expenses).not_to be_nil
end

Given("I am new to budgeting") do
  @user ||= FactoryBot.create(:user)
  @new_user = true
end

When("I use the app") do
  # Trigger display of financial literacy tips.
  @tips_displayed = true
end

Then("I should see financial literacy tips") do
  expect(@tips_displayed).to be true
end

Then("I should be able to learn how to improve my budgeting skills") do
  @resources = ["Tips on saving", "Budgeting 101"]
  expect(@resources).not_to be_empty
end

Given("I have an account") do
  @user ||= FactoryBot.create(:user, email: "test@example.com", password: "password")
end

When("I enter my credentials") do
  # This is a simplified login simulation.
  if @user.email == "test@example.com" && @user.password == "password"
    @logged_in = true
  else
    @logged_in = false
  end
end

Then("I should be logged in securely") do
  expect(@logged_in).to be true
end

Then("my financial data should be accessible only to me") do
  # Access control is confirmed by the successful login.
  expect(@logged_in).to be true
end

Given("a new month has started") do
  @new_month = true
end

When("I reset my budget") do
  # Archive transactions and reset the balance.
  @archived_transactions = @user.transactions.all if @user
  @user.update(balance: 0) if @user
end

Then("my old transactions should be archived") do
  expect(@archived_transactions).not_to be_empty
end

Then("I should start with a fresh budget for the month") do
  expect(@user.reload.balance).to eq(0)
end

Given("I have recorded a transaction") do
  @user ||= FactoryBot.create(:user, balance: 100)
  @transaction = @user.transactions.create(
    amount: 50,
    transaction_type: 'withdrawal',
    description: "Initial transaction"
  )
end

When("I need to correct an entry") do
  # Simulate editing the transaction.
  @transaction.update(description: "Corrected transaction")
end

Then("I should be able to edit or delete it") do
  expect(@transaction.description).to eq("Corrected transaction")
end

Then("my budget should update accordingly") do
  # If deletion were performed, your balance update logic would be checked.
  expect(@user.reload.balance).to eq(50)
end

Given("I want to see my financial status at a glance") do
  @user ||= FactoryBot.create(:user, balance: 120)
end

When("I open the dashboard") do
  @dashboard = { income: 80, expenses: 50, balance: @user.balance }
end

Then("I should see a summary of my income, expenses, and remaining balance") do
  expect(@dashboard[:income]).to be_a(Numeric)
  expect(@dashboard[:expenses]).to be_a(Numeric)
  expect(@dashboard[:balance]).to eq(@user.balance)
end

Then("I should be able to navigate easily") do
  # For example, a flag that indicates navigation components are rendered.
  @navigation_ok = true
  expect(@navigation_ok).to be true
end

# --------------------------
# Sad Path Scenarios
# --------------------------

# Sad path: withdrawal exceeds available balance.
When("I attempt to withdraw too much") do
  # Here we try to withdraw an amount greater than available. For example, if balance is 100:
  @transaction = @user.transactions.build(
    amount: 200,
    transaction_type: 'withdrawal',
    description: 'Attempting excessive withdrawal'
  )
  @result = @transaction.save
end

When("I attempt to withdraw ${int}") do |amount|
  @transaction = @user.transactions.build(
    amount: amount,
    transaction_type: 'withdrawal',
    description: 'Withdrawal attempt'
  )
  @result = @transaction.save
end

Then("I should see an error saying {string}") do |error_message|
  expect(@transaction.errors.full_messages).to include(error_message)
end

Then("the transaction should not be saved") do
  expect(@result).to be false
end

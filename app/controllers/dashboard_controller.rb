class DashboardController < ApplicationController
  before_action :require_user

  def index
    @user = current_user
    # Build a simple dashboard summary.
    @dashboard = {
      income: @user.transactions.where(transaction_type: 'deposit').sum(:amount),
      expenses: @user.transactions.where(transaction_type: 'withdrawal').sum(:amount),
      balance: @user.balance
    }
    # You can later render a view that shows graphs/charts.
  end
end

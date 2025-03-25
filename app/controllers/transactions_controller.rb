class TransactionsController < ApplicationController
  # Removed :show from before_action to avoid missing callback issues
  before_action :set_transaction, only: [:edit, :update, :destroy]

  def index
    @transactions = Transaction.order(transaction_date: :desc)
    @total_balance = Transaction.total_balance
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to transactions_path, notice: "Transaction was successfully recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to transactions_path, notice: "Transaction was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
    redirect_to transactions_path, notice: "Transaction was successfully deleted."
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :transaction_date, :category, :transaction_type, :due_date)
  end
end

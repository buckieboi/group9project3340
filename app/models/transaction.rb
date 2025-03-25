class Transaction < ApplicationRecord
  validates :amount, presence: true, numericality: true
  validates :description, presence: true
  validates :transaction_date, presence: true
  validates :transaction_type, inclusion: { in: ["income", "expense", "withdrawal", "saving"] }
  validates :category, presence: true, if: -> { transaction_type == "expense" }

  scope :income, -> { where(transaction_type: "income") }
  scope :expenses, -> { where(transaction_type: "expense") }
  scope :withdrawals, -> { where(transaction_type: "withdrawal") }
  scope :savings, -> { where(transaction_type: "saving") }

  def self.total_balance
    income.sum(:amount) - expenses.sum(:amount) - withdrawals.sum(:amount) - savings.sum(:amount)
  end
end

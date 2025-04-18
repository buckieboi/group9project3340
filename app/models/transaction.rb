class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }
  validates :transaction_type, inclusion: { in: %w(withdrawal deposit) }

  validate :sufficient_funds_for_withdrawal, if: -> { transaction_type == 'withdrawal' }

  after_create :update_user_balance

  private

  def sufficient_funds_for_withdrawal
    if user && amount > user.balance
      errors.add(:amount, "exceeds available balance")
    end
  end

  def update_user_balance
    if transaction_type == 'withdrawal'
      user.update(balance: user.balance - amount)
    elsif transaction_type == 'deposit'
      user.update(balance: user.balance + amount)
    end
  end
end

class User < ApplicationRecord
  has_secure_password  # Requires gem 'bcrypt' in your Gemfile

  has_many :transactions, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  # Reset budget by archiving all current transactions and setting balance to zero.
  def reset_budget!
    if transactions.any?
      transactions.update_all(archived: true)
    end
    update(balance: 0)
  end
end

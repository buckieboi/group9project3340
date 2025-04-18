class Subscription < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :monthly_cost, numericality: { greater_than_or_equal_to: 0 }
end
r
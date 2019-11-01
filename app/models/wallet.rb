class Wallet < ApplicationRecord
  belongs_to :account, class_name: 'Account::Base'
  validates :account, presence: true
  before_save :validate_balance

  private

  def increase(amount)
    self.balance += amount
    self.save!
  end

  def decrease(amount)
    self.balance -= amount
    self.save!
  end

  def validate_balance
    return if balance >= 0
    raise StandardError.new 'Balance cannot be negative'
  end
end

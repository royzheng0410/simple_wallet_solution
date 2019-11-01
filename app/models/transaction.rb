class Transaction < ApplicationRecord
  VALID_TYPE = {credit: 'credit', debit: 'debit'}
  belongs_to :sender, class_name: 'Account::Base'
  belongs_to :receiver, class_name: 'Account::Base'
  validates :sender, :receiver, presence: true
  validates :amount, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 10000 } #at most 2 decimal and not greater than 10000
  validates :transaction_type, :inclusion => {:in => VALID_TYPE.values}
  validate :has_sufficient_balance
  validate :sender_not_equal_to_receiver

  before_create :update_accounts

  scope :for_account, ->(account_id) {
    account_id = account_id.is_a?(Integer) ? account_id : Account::Base.find(account_id.id).id
    where("sender_id = :account_id or receiver_id = :account_id", :account_id => account_id)
  }

  private

  def update_accounts
    case transaction_type
    when VALID_TYPE[:credit]
      sender.send(:decrease, amount)
      receiver.send(:increase, amount)
    when VALID_TYPE[:debit]
      receiver.send(:decrease, amount)
      sender.send(:increase, amount)
    end
  end

  def has_sufficient_balance
    if sender_and_receiver_present
      case transaction_type
      when VALID_TYPE[:credit]
        return if sender.balance >= amount
        errors.add(:amount, 'exceeds available balance')
      when VALID_TYPE[:debit]
        return if receiver.balance >= amount
        errors.add(:amount, "exceeds receiver's available balance")
      end
    end
  end


  def sender_not_equal_to_receiver
    if sender_and_receiver_present
      return if sender_id != receiver_id
      errors.add(:receiver_id, "cannot equal to sender account")
    end
  end


  def sender_and_receiver_present
    sender_id.present? && receiver_id.present?
  end
end

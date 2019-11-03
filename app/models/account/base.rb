class Account::Base < ApplicationRecord
  self.table_name = "accounts"

  has_one :wallet, foreign_key: 'account_id'
  has_many :sent_transactions, foreign_key: 'sender_id', class_name: 'Transaction'
  has_many :received_transactions, foreign_key: 'receiver_id', class_name: 'Transaction'
  validates :account_number, presence: true, uniqueness: true

  before_validation :generate_acount_number, on: :create
  before_create :build_default_wallet

  scope :not_sender, ->(sender_id){
    sender_id = sender_id.is_a?(Integer) ? sender_id : find(sender_id.id).id
    where.not(id: sender_id)
  }

  def balance
    wallet.balance
  end

  def display_name
    account_name + "(#{account_number})"
  end

  def decrease(amount)
    wallet.decrease(amount)
  end

  def increase(amount)
    wallet.increase(amount)
  end

  private

  def generate_acount_number
    self.account_number = rand.to_s[2..10]
  end

  def build_default_wallet
    build_wallet
    true
  end

end
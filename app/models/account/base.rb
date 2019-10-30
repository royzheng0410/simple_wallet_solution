class Account::Base < ApplicationRecord
  self.table_name = "accounts"

  has_one :wallet, foreign_key: 'account_id'
  has_many :sent_transactions, foreign_key: 'sender_id', class_name: 'Transaction'
  has_many :received_transactions, foreign_key: 'receiver_id', class_name: 'Transaction'
  validates :account_number, presence: true, uniqueness: true

  before_validation :generate_acount_number, on: :create
  before_create :build_default_wallet

  private

  def generate_acount_number
    self.account_number = rand(10 ** 8)
  end

  def build_default_wallet
    build_wallet
    true
  end

end
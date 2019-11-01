require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before do
    @user_account1 = FactoryGirl.create :user_account, first_name: 'Tom', last_name: 'Cruise'
    @user_account2 = FactoryGirl.create :user_account, first_name: 'Brad', last_name: 'Pitt'
  end
  describe '#validate a transaction' do
    it 'should have a sender and receiver id' do
      expect(Transaction.new(amount: 10, transaction_type: Transaction::VALID_TYPE[:credit], receiver_id: @user_account2.id)).not_to be_valid
    end
  end
end

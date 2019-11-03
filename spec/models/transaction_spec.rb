require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before do
    @user_account1 = FactoryGirl.create :user_account, first_name: 'Tom', last_name: 'Cruise'
    
    @user_account2 = FactoryGirl.create :user_account, first_name: 'Brad', last_name: 'Pitt'
    
  end
  describe '#validate a transaction' do
    it 'should not be valid if have a sender or receiver id missing' do
      expect(Transaction.new(amount: 10, transaction_type: Transaction::VALID_TYPE[:credit], receiver_id: @user_account2.id)).not_to be_valid
    end

    it 'should not be valid if have one account as both sender and receiver ' do
      expect(Transaction.new(amount: 10, transaction_type: Transaction::VALID_TYPE[:credit], receiver_id: @user_account2.id, sender_id: @user_account2.id)).not_to be_valid
    end

    it 'should not be valid if sender does not have sufficient balance to send a credit trnasation' do
      expect(Transaction.new(amount: 105, transaction_type: Transaction::VALID_TYPE[:credit], receiver_id: @user_account2.id, sender_id: @user_account1.id)).not_to be_valid
    end

    it 'should not be valid if receiver does not have sufficient balance to receive a debit trnasation' do
      expect(Transaction.new(amount: 105, transaction_type: Transaction::VALID_TYPE[:debit], receiver_id: @user_account2.id, sender_id: @user_account1.id)).not_to be_valid
    end

    it 'should not be valid if receiver does not exist in system' do
      expect(Transaction.new(amount: 10, transaction_type: Transaction::VALID_TYPE[:credit], receiver_id: 10000000000, sender_id: @user_account1.id)).not_to be_valid
    end

    it 'should not be valid if the transaction type is not recognised' do
      expect(Transaction.new(amount: 10, transaction_type: 'fraud', receiver_id: @user_account2.id, sender_id: @user_account1.id)).not_to be_valid
    end

    it 'should not be valid if the transaction type is null' do
      expect(Transaction.new(amount: 10, transaction_type: nil, receiver_id: @user_account2.id, sender_id: @user_account1.id)).not_to be_valid
    end

    it 'should not be valid if the amount is not valid' do
      expect(Transaction.new(amount: 'money', transaction_type: Transaction::VALID_TYPE[:credit], receiver_id: @user_account2.id, sender_id: @user_account1.id)).not_to be_valid
    end

    it 'should not be valid if the amount is null' do
      expect(Transaction.new(amount: nil, transaction_type: Transaction::VALID_TYPE[:credit], receiver_id: @user_account2.id, sender_id: @user_account1.id)).not_to be_valid
    end

    it 'should be valid if all validation passed' do
      expect(Transaction.new(amount: 10, transaction_type: Transaction::VALID_TYPE[:credit], receiver_id: @user_account2.id, sender_id: @user_account1.id)).to be_valid
    end
  end
end

require 'rails_helper'

RSpec.describe Account::Base, type: :model do
  before do
    @account1 = FactoryGirl.create :base_account
  end
  describe '#validate an account' do
    it 'should have a unique account number' do
      @account2 = FactoryGirl.create :base_account
      expect(@account1.account_number.length).to eq 9
      expect(@account1.account_number).not_to eq @account2.account_number
    end

    it 'should have a wallet with balance of 0 upon creation' do
      expect(@account1.wallet.present?).to eq true
      expect(@account1.wallet.balance).to eq 0
    end
  end

  describe '#instance methods' do
    it 'should return balance of the wallet' do
      @wallet = @account1.wallet
      @wallet.update(balance: 100)
      expect(@account1.balance).to eq 100
    end

    it 'should display name to users' do
      @account1.account_name = 'base account'
      @account1.save
      expect(@account1.display_name).to eq "base account(#{@account1.account_number})"
    end
  end
end
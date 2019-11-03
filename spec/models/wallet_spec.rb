require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe '#validate a wallet' do
    it 'should have an account' do
      expect(Wallet.new(balance: 100)).not_to be_valid
    end

    it 'should raise error if balance about to be negative' do
      @user_account = FactoryGirl.create :user_account
      @wallet = @user_account.wallet
      @wallet.balance = -5
      expect{@wallet.save}.to raise_error(StandardError)
    end
  end

  describe '#public methods' do
    before do
      @user_account = FactoryGirl.create :user_account
      @wallet = @user_account.wallet
    end
    it 'should increase balance' do
      @wallet.increase(50)
      expect(@wallet.balance).to eq 150
    end

    it 'should decrease balance' do
      @wallet.decrease(50)
      expect(@wallet.balance).to eq 50
    end
  end
end

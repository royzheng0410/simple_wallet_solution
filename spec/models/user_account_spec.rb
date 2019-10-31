require 'rails_helper'

RSpec.describe Account::User, type: :model do
  describe 'User account model methods' do
    before do
      @user_account1 = FactoryGirl.create(:user_account)
      @user_account2 = FactoryGirl.create(:user_account)
    end

    it 'should have different account number' do
      expect(@user_account1.account_number).not_to eq @user_account2.account_number
    end

    it 'should have full name' do
      expect(@user_account1.full_name).to eq 'Roy Zheng'
    end
  end
end
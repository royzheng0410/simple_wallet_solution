FactoryGirl.define do
  factory :user_account, class: Account::User do
    first_name 'Roy'
    last_name  'Zheng'
    account_name 'user account'
    type 'Account::User'
  end
end
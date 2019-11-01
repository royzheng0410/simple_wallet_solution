FactoryGirl.define do
  factory :stock_account, class: Account::Stock do
    stock_name 'Accounting'
    type 'Account::Stock'
  end
end
FactoryGirl.define do
  factory :team_account, class: Account::Team do
    team_name 'Accounting'
    type 'Account::Team'
  end
end
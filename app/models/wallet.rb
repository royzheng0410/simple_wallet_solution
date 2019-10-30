class Wallet < ApplicationRecord
  belongs_to :account, class_name: 'Account::Base'
end

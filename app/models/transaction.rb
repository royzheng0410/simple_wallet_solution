class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'Account::Base'
  belongs_to :receiver, class_name: 'Account::Base'
end

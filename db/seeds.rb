# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p "Seeding account"
Account::User.create!(account_name: 'user account', first_name: 'Tom', last_name: 'Cruise')
Account::User.create!(account_name: 'user account', first_name: 'Brad', last_name: 'Pitt')
Account::User.create!(account_name: 'user account', first_name: 'Orlando', last_name: 'Bloom')

Account::Team.create!(account_name: 'team account', team_name: 'Account')
Account::Team.create!(account_name: 'team account', team_name: 'IT')
Account::Team.create!(account_name: 'team account', team_name: 'Human Resource')

Account::Stock.create!(account_name: 'stock account', stock_name: 'Apple')
Account::Stock.create!(account_name: 'stock account', stock_name: 'Goole')
Account::Stock.create!(account_name: 'stock account', stock_name: 'Facebook')
p "#{Account::Base.count} accounts have been seeded"

p "Updating balance of wallets"
Wallet.update_all(balance: 100)

p "#{Wallet.count} wallets have been updated"
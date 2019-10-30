class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :type
      t.string :account_name
      t.string :account_number, null: false
      t.string :first_name
      t.string :last_name
      t.string :team_name
      t.string :stock_name


      t.timestamps
    end

    add_index :accounts, :account_number, unique: true
  end
end

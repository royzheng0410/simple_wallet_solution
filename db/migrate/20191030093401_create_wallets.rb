class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
      t.integer :account_id
      t.decimal :balance, default: 0, null: false
      t.timestamps
    end
  end
end

class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer  :sender_id
      t.integer  :receiver_id
      t.string   :transaction_type
      t.decimal  :amount, default: 0
      t.timestamps
    end
  end
end

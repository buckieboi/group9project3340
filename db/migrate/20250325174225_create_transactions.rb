class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :description
      t.date :transaction_date
      t.string :category
      t.string :transaction_type

      t.timestamps
    end
  end
end

class AddDueDateToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :due_date, :date
  end
end

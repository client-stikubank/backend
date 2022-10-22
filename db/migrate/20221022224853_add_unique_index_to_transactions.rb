class AddUniqueIndexToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_index :transactions, [:sourceable_id, :transactable_id, :subject], unique: true, name: 'dup_transaction_index'
  end
end

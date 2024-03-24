class RemoveUniqueIndexOnUsersEmail < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :email
    add_index :users, :email, unique: true, where: "discarded_at IS NULL"
  end
end

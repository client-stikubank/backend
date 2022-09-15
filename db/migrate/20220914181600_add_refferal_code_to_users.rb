class AddRefferalCodeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :refferal_code, :string, index: true, unique: true
  end
end

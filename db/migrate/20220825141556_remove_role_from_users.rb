class RemoveRoleFromUsers < ActiveRecord::Migration[7.0]
  def change
    def up
      remove_column :users, :role
    end

    def down
      add_column :users, :role, :string
    end
  end
end

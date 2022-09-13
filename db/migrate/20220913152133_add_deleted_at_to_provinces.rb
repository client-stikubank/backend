class AddDeletedAtToProvinces < ActiveRecord::Migration[7.0]
  def change
    add_column :provinces, :deleted_at, :datetime
    add_index :provinces, :deleted_at
  end
end

class CreateGifts < ActiveRecord::Migration[7.0]
  def change
    create_table :gifts, id: :uuid do |t|
      t.string   :name
      t.string   :image
      t.text     :description
      t.bigint   :amount, default: 0
      t.datetime :deleted_at, index: true
      t.timestamps
    end

    add_index :gifts, [:name, :deleted_at], unique: true
  end
end

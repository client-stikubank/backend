class CreateCoins < ActiveRecord::Migration[7.0]
  def change
    create_table :coins, id: :uuid do |t|
      t.integer :name, null: false, unique: true
      t.text    :description
      t.bigint  :max_supply, null: false, default: 0
      t.string  :image

      t.timestamps
    end
  end
end

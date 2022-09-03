class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks, id: :uuid do |t|
      t.belongs_to :coin, type: :uuid, foreign_key: true, unique: true
      t.bigint     :balance, null: false, default: 0

      t.timestamps
    end
  end
end

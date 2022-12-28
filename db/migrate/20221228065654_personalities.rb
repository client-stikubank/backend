class Personalities < ActiveRecord::Migration[7.0]
  def change
    create_table :personalities, id: :uuid do |t|
      t.string :code
      t.string :name
      t.string :image
      t.text   :description
      t.timestamps
    end

    add_index :personalities, [:code], unique: true
  end
end

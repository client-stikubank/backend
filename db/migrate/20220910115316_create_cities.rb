class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities, id: :uuid do |t|
      t.string   :name
      t.references :province, foreign_key: true, type: :uuid, index: true
      t.timestamps
    end
  end
end

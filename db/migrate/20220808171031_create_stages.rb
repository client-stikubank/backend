class CreateStages < ActiveRecord::Migration[7.0]
  def change
    create_table :stages, id: :uuid do |t|
      t.string :name, null: false
      t.belongs_to :carnival, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end

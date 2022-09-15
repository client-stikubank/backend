class CreateRefferals < ActiveRecord::Migration[7.0]
  def change
    create_table :refferals, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.references :reffered_by, type: :uuid, index: true, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end

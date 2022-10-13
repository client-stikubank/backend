class CreateCarnivalGifts < ActiveRecord::Migration[7.0]
  def change
    create_table :carnival_gifts, id: :uuid do |t|
      t.references :gift, foreign_key: true, type: :uuid, index: true
      t.references :carnival, foreign_key: true, type: :uuid, index: true
      t.integer    :quantity, default: 0
      t.integer    :status, default: 0
      t.timestamps
    end
  end
end

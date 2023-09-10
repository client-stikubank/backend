class CreateQrClue < ActiveRecord::Migration[7.0]
  def change
    create_table :qr_clues, id: :uuid do |t|
      t.text :clue
      t.string :image

      t.timestamps
    end
  end
end

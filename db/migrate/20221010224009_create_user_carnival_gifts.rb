class CreateUserCarnivalGifts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_carnival_gifts, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.references :carnival_gift, foreign_key: true, type: :uuid, index: true
      t.integer    :status, default: 0
      t.timestamps
    end
  end
end

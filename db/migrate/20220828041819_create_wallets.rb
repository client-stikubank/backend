class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.belongs_to :coin, type: :uuid, foreign_key: true
      t.bigint     :balance, null: false, default: 0

      t.timestamps
    end

    add_index :wallets, [:user_id, :coin_id], unique: true
  end
end

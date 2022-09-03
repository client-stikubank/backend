class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :sourceable, index: true, polymorphic: true, type: :uuid
      t.references :transactable, index: true, polymorphic: true, type: :uuid
      t.integer    :subject, null: false

      t.timestamps
    end

    create_table :rewards, id: :uuid do |t|
      t.bigint     :amount, null: false, default: 0
      t.references :from, type: :uuid, foreign_key: { to_table: :stocks }
      t.references :to, type: :uuid, foreign_key: { to_table: :wallets }
      t.references :activitable, index: true, polymorphic: true, type: :uuid
      t.belongs_to :coin, type: :uuid, foreign_key: true
      t.integer    :reward_type, null: false
      t.string     :status

      t.timestamps
    end

    create_table :redeems, id: :uuid do |t|
      t.bigint     :amount, null: false, default: 0
      t.references :from, type: :uuid, foreign_key: { to_table: :wallets }
      t.references :to, type: :uuid, foreign_key: { to_table: :stocks }
      t.references :kindable, index: true, polymorphic: true, type: :uuid
      t.belongs_to :coin, type: :uuid, foreign_key: true
      t.integer    :redeem_type, null: false
      t.string     :status

      t.timestamps
    end

    create_table :transfers, id: :uuid do |t|
      t.bigint     :amount, null: false, default: 0
      t.references :from, type: :uuid, foreign_key: { to_table: :wallets }
      t.references :to, type: :uuid, foreign_key: { to_table: :wallets }
      t.belongs_to :coin, type: :uuid, foreign_key: true
      t.string     :status

      t.timestamps
    end
  end
end

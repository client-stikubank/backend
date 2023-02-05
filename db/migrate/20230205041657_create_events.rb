class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events, id: :uuid do |t|
      t.string   :title
      t.string   :image
      t.text     :description
      t.integer  :reward_amount, array: true, default: [0, 0, 0, 0]
      t.datetime :start_date
      t.datetime :end_date
      t.integer  :status, null: false, default: 0
      t.datetime :deleted_at, index: true
      t.timestamps
    end

    add_index :events, [:title, :deleted_at], unique: true
  end
end

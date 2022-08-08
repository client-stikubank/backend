class CreateCamps < ActiveRecord::Migration[7.0]
  def change
    create_table :camps, id: :uuid do |t|
      t.string  :title, null: false
      t.text    :description
      t.integer :level, null: false, default: 1
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end

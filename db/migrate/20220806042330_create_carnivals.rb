class CreateCarnivals < ActiveRecord::Migration[7.0]
  def change
    create_table :carnivals, id: :uuid do |t|
      t.string  :name,        null: false
      t.integer :status,      null: false, default: 0
      t.date    :finished_at

      t.timestamps
    end
  end
end

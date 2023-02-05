class CreateUserEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :user_events, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.references :event, foreign_key: true, type: :uuid, index: true
      t.integer    :status, default: 0
      t.timestamps
    end
  end
end

class AddDurationToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :duration, :string
    add_column :events, :event_at, :datetime
  end
end

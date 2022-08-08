class CreateStageSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :stage_schedules, id: :uuid do |t|
      t.belongs_to :stage_camp, type: :uuid, foreign_key: true
      t.date       :started_at, null: false
      t.string     :time_start, null: false
      t.string     :time_end, null: false
      t.integer    :quota, null: false

      t.timestamps
    end
  end
end

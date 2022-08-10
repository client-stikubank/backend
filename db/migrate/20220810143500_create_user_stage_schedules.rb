class CreateUserStageSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :user_stage_schedules, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.belongs_to :stage_schedule, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end

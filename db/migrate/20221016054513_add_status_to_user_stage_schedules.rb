class AddStatusToUserStageSchedules < ActiveRecord::Migration[7.0]
  def change
    add_column :user_stage_schedules, :status, :integer, null: false, default: 0
  end
end

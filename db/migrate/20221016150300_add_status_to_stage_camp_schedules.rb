class AddStatusToStageCampSchedules < ActiveRecord::Migration[7.0]
  def change
    add_column :stage_camp_schedules, :status, :integer, null: false, default: 0
  end
end

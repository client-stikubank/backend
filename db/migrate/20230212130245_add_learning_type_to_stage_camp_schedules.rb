class AddLearningTypeToStageCampSchedules < ActiveRecord::Migration[7.0]
  def change
    add_column :stage_camp_schedules, :learning_type, :integer, default: 0
  end
end

class AddLinkToStageCampSchedules < ActiveRecord::Migration[7.0]
  def change
    add_column :stage_camp_schedules, :link, :string
  end
end

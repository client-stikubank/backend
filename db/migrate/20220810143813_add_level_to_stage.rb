class AddLevelToStage < ActiveRecord::Migration[7.0]
  def change
    add_column :stages, :level, :integer
  end
end

class CreateStageCamps < ActiveRecord::Migration[7.0]
  def change
    create_table :stage_camps, id: :uuid do |t|
      t.belongs_to :stage, type: :uuid, foreign_key: true
      t.belongs_to :camp, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end

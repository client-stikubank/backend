class CreateAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments, id: :uuid do |t|
      t.integer :status, null: false, default: 0
      t.references :programmable, polymorphic: true, type: :uuid, index: true

      t.timestamps
    end
  end
end

class CreateParentInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :parent_informations, id: :uuid do |t|
      t.references :user_profile, foreign_key: true, type: :uuid, index: true
      t.integer  :graduate_status
      t.string   :occupation
      t.integer  :salary_level
      t.timestamps
    end
  end
end

class CreateStudentInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :student_informations, id: :uuid do |t|
      t.references :user_profile, foreign_key: true, type: :uuid, index: true
      t.integer  :education_status
      t.string   :previous_school
      t.timestamps
    end
  end
end

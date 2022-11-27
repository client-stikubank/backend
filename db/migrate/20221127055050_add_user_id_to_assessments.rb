class AddUserIdToAssessments < ActiveRecord::Migration[7.0]
  def change
    add_reference :assessments, :user, foreign_key: true, type: :uuid, index: true
    add_column :assessments, :completed_at, :datetime
  end
end

class AddResultsToAssessments < ActiveRecord::Migration[7.0]
  def change
    add_column :assessments, :results, :jsonb
    add_reference :assessments, :personality, foreign_key: true, type: :uuid, index: true
  end
end

class AddChoiceTypeToAssessmentQuestion < ActiveRecord::Migration[7.0]
  def change
    remove_column :assessment_questions, :choice_type, :integer
    add_column :assessment_questions, :choice_1_type, :string
    add_column :assessment_questions, :choice_2_type, :string
    add_column :assessment_questions, :status, :integer, default: 0
  end
end

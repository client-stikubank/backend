class CreateAssessmentQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :assessment_questions, id: :uuid do |t|
      t.string  :question
      t.string  :choice_1_text
      t.string  :choice_2_text
      t.string  :choice_1_image
      t.string  :choice_2_image
      t.integer :choice_type

      t.timestamps
    end
  end
end

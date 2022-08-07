class CreateAssessmentAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :assessment_answers, id: :uuid do |t|
      t.belongs_to :assessment
      t.belongs_to :assessment_question
      t.belongs_to :user
      t.integer    :answer, inclusion: 0..1
      t.integer    :index_order

      t.timestamps
    end
  end
end

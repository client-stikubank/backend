class CreateAssessmentAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :assessment_answers, id: :uuid do |t|
      t.belongs_to :assessment, type: :uuid, foreign_key: true
      t.belongs_to :assessment_question, type: :uuid, foreign_key: true
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.integer    :answer, inclusion: 0..1
      t.integer    :index_order

      t.timestamps
    end
  end
end

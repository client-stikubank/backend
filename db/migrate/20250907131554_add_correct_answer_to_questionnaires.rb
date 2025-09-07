class AddCorrectAnswerToQuestionnaires < ActiveRecord::Migration[7.0]
  def change
    add_column :questionnaires, :correct_answer, :string
  end
end

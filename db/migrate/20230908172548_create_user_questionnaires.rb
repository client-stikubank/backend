class CreateUserQuestionnaires < ActiveRecord::Migration[7.0]
  def change
    create_table :user_questionnaires, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.references :questionnaire, foreign_key: true, type: :uuid, index: true
      t.string     :answer

      t.timestamps
    end
  end
end

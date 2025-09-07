class QuestionnaireSerializer
  include JSONAPI::Serializer

  attributes :question, :answers, :start_date, :end_date, :status, :reward_amount, :correct_answer
end

class UserQuestionnaireSerializer
  include JSONAPI::Serializer

  attributes :questionnaire_id, :answer

  attribute :user do |object|
    object.user
  end

  attribute :questionnaire do |object|
    object.questionnaire
  end
end

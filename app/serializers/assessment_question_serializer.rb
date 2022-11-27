class AssessmentQuestionSerializer
  include JSONAPI::Serializer

  attributes :question, :choice_1_text, :choice_2_text, :choice_1_image, :choice_2_image,
             :choice_1_type, :choice_2_type, :status
end

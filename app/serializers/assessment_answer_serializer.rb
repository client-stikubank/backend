class AssessmentQuestionSerializer
  include JSONAPI::Serializer

  attributes :index_order, :answer

  attribute :assessment_question do |object|
    AssessmentQuestion.new(object.assessment_question).serializable_hash
  end
end

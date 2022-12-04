class AssessmentSerializer
  include JSONAPI::Serializer

  attributes :completed_at, :status

  attribute :assessment_answers do |object|
    AssessmentAnswer.new(object.assessment_answers).serializable_hash
  end

  attribute :user do |object|
    object.user
  end
end

class AssessmentSerializer
  include JSONAPI::Serializer

  attributes :completed_at, :status

  attribute :assessment_answers do |object|
    AssessmentAnswerSerializer.new(object.assessment_answers).serializable_hash
  end

  attribute :user do |object|
    UserSerializer.new(object.user).serializable_hash
  end
end

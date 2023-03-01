class ActiveCarnivalSerializer
  include JSONAPI::Serializer

  attributes :current_stage, :current_assessment_index

  attribute :carnival do |_object|
    CarnivalDetailSerializer.new(Carnival.active).serializable_hash
  end

  attribute :active_camps do |object|
    UserStageScheduleSerializer.new(object.active_camps).serializable_hash
  end

  attribute :pending_assessment do |object|
    AssessmentSerializer.new(object.pending_assessment).serializable_hash
  end

  attribute :last_assessment do |object|
    AssessmentSerializer.new(object.last_assessment).serializable_hash
  end

  attribute :finished_camps do |object|
    CampSerializer.new(object.camps.finished).serializable_hash
  end

  attribute :finished_schedules do |object|
    UserStageScheduleSerializer.new(object.finished_schedules).serializable_hash
  end
end

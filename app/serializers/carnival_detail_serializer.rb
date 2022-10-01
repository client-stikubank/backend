class CarnivalDetailSerializer
  include JSONAPI::Serializer

  attributes :name, :status, :description, :finished_at

  attribute :stages do |object|
    object.stages
  end

  attribute :user_stage_schedules do |object|
    UserStageScheduleSerializer.new(object.user_stage_schedules).serializable_hash
  end
end

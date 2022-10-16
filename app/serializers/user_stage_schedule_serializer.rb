class UserStageScheduleSerializer
  include JSONAPI::Serializer

  attributes :status

  attribute :stage_camp_schedule do |object|
    object.stage_camp_schedule
  end

  attribute :stage_camp do |object|
    StageCampSerializer.new(object.stage_camp).serializable_hash
  end
end

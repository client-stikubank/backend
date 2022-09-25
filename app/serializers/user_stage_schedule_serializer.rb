class UserStageScheduleSerializer
  include JSONAPI::Serializer

  attribute :stage_camp_schedule do |object|
    object.stage_camp_schedule
  end
end

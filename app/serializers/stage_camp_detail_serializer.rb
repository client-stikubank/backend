class StageCampDetailSerializer
  include JSONAPI::Serializer

  attribute :stage do |object|
    object.stage
  end

  attribute :camp do |object|
    object.camp
  end

  attribute :stage_camp_schedules do |object|
    object.stage_camp_schedules
  end
end

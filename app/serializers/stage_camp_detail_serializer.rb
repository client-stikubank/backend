class StageCampDetailSerializer
  include JSONAPI::Serializer

  attribute :stage do |object|
    object.stage
  end

  attribute :camp do |object|
    object.camp
  end

  attribute :stage_camp_schedules do |object|
    schedules = []
    StageCampSchedule.all.order(started_at: :asc).group_by(&:started_at).each do |key, group|
      schedules << { date: key, schedules: group }
    end
    schedules
  end
end

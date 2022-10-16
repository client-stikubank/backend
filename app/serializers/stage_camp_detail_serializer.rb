class StageCampDetailSerializer
  include JSONAPI::Serializer

  attribute :stage do |object|
    object.stage
  end

  attribute :camp do |object|
    object.camp
  end

  attribute :stage_camp_schedules do |object|
    upcoming_schedules = object.stage_camp_schedules.upcoming
    schedules = []

    return schedules unless upcoming_schedules.present?

    upcoming_schedules.order(started_at: :asc).group_by(&:started_at).each do |key, group|
      schedule = group.map{ |g| g.attributes.symbolize_keys.merge!(joined_count: g.joined_count, full: g.is_full?) }
      schedules << { date: key, schedules: schedule }
    end
    schedules
  end
end

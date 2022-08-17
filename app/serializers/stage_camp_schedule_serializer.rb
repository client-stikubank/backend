class StageCampScheduleSerializer
  include JSONAPI::Serializer

  attributes :started_at, :time_start, :time_end, :quota

  attribute :className do |object|
    'bg-success text-white border-0'
  end

  attribute :id do |object|
    object.id
  end

  attribute :start do |object|
    time_start = object.time_start.split(':')
    hours = object.time_start[0].to_i.hours
    minutes = object.time_start[1].to_i.minutes
    (object.started_at + hours + minutes).to_datetime
  end

  attribute :title do |object|
    "#{object.time_start} - #{object.time_end}, 0/#{object.quota}"
  end
end

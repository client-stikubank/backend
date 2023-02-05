class UserEventSerializer
  include JSONAPI::Serializer

  attributes :event_id, :status

  attribute :user do |object|
    object.user
  end

  attribute :event do |object|
    object.event
  end
end

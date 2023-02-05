class EventSerializer
  include JSONAPI::Serializer

  attributes :name, :image, :start_date, :end_date, :status, :description, :reward_amount
end

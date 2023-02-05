class EventSerializer
  include JSONAPI::Serializer

  attributes :name, :image, :address, :map_link, :start_date, :end_date, :status, :description, :reward_amount, :duration, :event_at

  attribute :city do |object|
    CitySerializer.new(object.city).serializable_hash
  end
end

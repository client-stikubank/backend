class CampSerializer
  include JSONAPI::Serializer

  attributes :title, :description, :active?, :level, :reward_amount, :subtitle

  attribute :speaker do |object|
    UserSerializer.new(object.speaker).serializable_hash
  end
end

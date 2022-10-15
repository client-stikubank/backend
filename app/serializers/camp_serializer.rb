class CampSerializer
  include JSONAPI::Serializer

  attributes :title, :description, :active?, :level

  attribute :speaker do |object|
    UserSerializer.new(object.speaker).serializable_hash
  end
end

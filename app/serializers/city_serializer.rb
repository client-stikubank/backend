class CitySerializer
  include JSONAPI::Serializer

  attributes :name

  attribute :province do |object|
    object.province
  end
end

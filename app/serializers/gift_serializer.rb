class GiftSerializer
  include JSONAPI::Serializer

  attributes :name, :image, :description, :amount
end

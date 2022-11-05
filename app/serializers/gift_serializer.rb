class GiftSerializer
  include JSONAPI::Serializer

  attributes :name, :image, :description, :reward_amount
end

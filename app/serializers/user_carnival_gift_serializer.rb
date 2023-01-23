class UserCarnivalGiftSerializer
  include JSONAPI::Serializer

  attributes :carnival_gift_id, :status

  attribute :user do |object|
    object.user
  end

  attribute :gift do |object|
    object.gift
  end

  attribute :carnival do |object|
    object.carnival
  end
end

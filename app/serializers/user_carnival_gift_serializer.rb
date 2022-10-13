class UserCarnivalGiftSerializer
  include JSONAPI::Serializer

  attribute :user do |object|
    object.user
  end

  attribute :gift do |object|
    object.carnival_gift.gift
  end

  attribute :carnival do |object|
    object.carnival_gift.carnival
  end

  attribute :status
end

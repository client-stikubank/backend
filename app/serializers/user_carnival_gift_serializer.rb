class UserCarnivalGiftSerializer
  include JSONAPI::Serializer

  attribute :user do |object|
    object.user
  end

  attribute :gift do |object|
    object.gift
  end

  attribute :carnival do |object|
    object.carnival
  end

  attribute :status
end

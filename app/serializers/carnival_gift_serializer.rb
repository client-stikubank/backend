class CarnivalGiftSerializer
  include JSONAPI::Serializer

  attribute :gift do |object|
    object.gift
  end

  attribute :carnival do |object|
    object.carnival
  end

  attribute :quantity, :status
end

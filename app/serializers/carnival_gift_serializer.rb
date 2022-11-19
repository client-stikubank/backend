class CarnivalGiftSerializer
  include JSONAPI::Serializer

  attribute :quantity, :status

  attribute :out_of_stock do |object|
    object.out_of_stock?
  end

  attribute :redeemed_count do |object|
    object.redeemed_gifts.size
  end

  attribute :cancelled_count do |object|
    object.cancelled_gifts.size
  end

  attribute :gift do |object|
    object.gift
  end

  attribute :carnival do |object|
    object.carnival
  end
end

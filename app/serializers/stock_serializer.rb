class StockSerializer
  include JSONAPI::Serializer

  attributes :balance

  attribute :coin_name do |object|
    object.coin.name.capitalize
  end

  attribute :coin_max_supply do |object|
    object.coin.max_supply
  end
end

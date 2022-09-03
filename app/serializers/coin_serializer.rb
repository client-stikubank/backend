class CoinSerializer
  include JSONAPI::Serializer

  attributes :description, :max_supply

  attribute :name do |object|
    object.name.capitalize
  end
end

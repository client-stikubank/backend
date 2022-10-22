class RewardSerializer
  include JSONAPI::Serializer

  attributes :amount, :status, :reward_type

  attribute :coin do |object|
    CoinSerializer.new(object.coin).serializable_hash
  end

  attribute :activitable do |object|
    object.activitable
  end
end

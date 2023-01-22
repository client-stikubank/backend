class RewardSerializer
  include JSONAPI::Serializer

  attributes :amount, :status, :reward_type, :updated_at

  attribute :coin do |object|
    CoinSerializer.new(object.coin).serializable_hash
  end

  attribute :activitable do |object|
    case object.reward_type
    when 'join_camp'
      UserStageScheduleSerializer.new(object.activitable).serializable_hash
    when 'refferal'
      RefferalSerializer.new(object.activitable).serializable_hash
    else
      object.activitable
    end
  end
end

class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :refferal_code

  attribute :reffered_by do |object|
    object.refferal.user.user_profile.full_name if object.refferal.present?
  end

  attribute :role do |object|
    object.role
  end

  attribute :wallet_balance do |object|
    object.remaining_balance
  end

  attribute :user_profile do |object|
    UserProfileSerializer.new(object.user_profile).serializable_hash
  end
end

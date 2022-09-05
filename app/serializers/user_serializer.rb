class UserSerializer
  include JSONAPI::Serializer

  attributes :email

  attribute :role do |object|
    object.role
  end

  attribute :user_profile do |object|
    UserProfileSerializer.new(object.user_profile).serializable_hash
  end
end

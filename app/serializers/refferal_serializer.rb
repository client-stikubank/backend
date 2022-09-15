class RefferalSerializer
  include JSONAPI::Serializer

  attribute :user do |object|
    object.user.user_profile.full_name
  end

  attribute :refferal do |object|
    object.refferal.user_profile.full_name
  end
end

class UserProfileSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name, :phone_number, :birth_date
end

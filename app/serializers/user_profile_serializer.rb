class UserProfileSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name, :phone_number, :birth_date

  attribute :city do |object|
    CitySerializer.new(object.city).serializable_hash
  end

  attribute :additional_info do |object|
    object.parent_information
  end
end

class UserProfileSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name, :phone_number, :birth_date

  attribute :city do |object|
    CitySerializer.new(object.city).serializable_hash
  end

  attribute :additional_info do |object|
    if object.user.parent?
      ParentInformationSerializer.new(object.parent_information).serializable_hash
    else
      StudentInformationSerializer.new(object.student_information).serializable_hash
    end
  end
end

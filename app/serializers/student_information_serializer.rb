class StudentInformationSerializer
  include JSONAPI::Serializer

  attributes :education_status, :education_status_name, :previous_school
end

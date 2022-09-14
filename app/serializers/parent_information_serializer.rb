class ParentInformationSerializer
  include JSONAPI::Serializer

  attributes :graduate_status, :graduate_status_name, :occupation, :salary_level, :salary_range
end

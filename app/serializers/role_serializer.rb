class RoleSerializer
  include JSONAPI::Serializer

  attributes :name, :resource_id, :resource_type
end

class PermissionSerializer
  include JSONAPI::Serializer

  attributes :object_type, :action_name, :description
end

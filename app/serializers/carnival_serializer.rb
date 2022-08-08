class CarnivalSerializer
  include JSONAPI::Serializer

  attributes :name, :status, :description, :finished_at
end

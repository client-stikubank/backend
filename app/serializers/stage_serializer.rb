class StageSerializer
  include JSONAPI::Serializer

  attributes :name, :level
end

class CampSerializer
  include JSONAPI::Serializer

  attributes :title, :description, :active?, :level
end

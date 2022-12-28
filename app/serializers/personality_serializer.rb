class PersonalitySerializer
  include JSONAPI::Serializer

  attributes :code, :name, :image, :description
end

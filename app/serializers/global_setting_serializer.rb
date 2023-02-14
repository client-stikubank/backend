class GlobalSettingSerializer
  include JSONAPI::Serializer

  attributes :name, :code, :value
end

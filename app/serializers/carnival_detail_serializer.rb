class CarnivalDetailSerializer
  include JSONAPI::Serializer

  attributes :name, :status, :description, :finished_at

  attribute :stages do |object|
    object.stages
  end
end

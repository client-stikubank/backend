class CarnivalDetailSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :finished_at

  attribute :stages do |object|
    CarnivalStagesSerializer.new(object.stages).serializable_hash
  end
end

class StageSerializer
  include JSONAPI::Serializer

  attributes :name, :level

  attribute :stage_camps do |object|
    stage_camps = object.stage_camps.includes(:camp).where(camps: { status: 1 })

    StageCampSerializer.new(stage_camps).serializable_hash
  end
end

module Admin
  class StageSerializer
    include JSONAPI::Serializer

    attributes :name, :level

    attribute :stage_camps do |object|
      ::StageCampSerializer.new(object.stage_camps).serializable_hash
    end
  end
end

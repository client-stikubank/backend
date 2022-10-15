class StageCampSerializer
  include JSONAPI::Serializer

  attribute :stage do |object|
    object.stage
  end

  attribute :camp do |object|
    CampSerializer.new(object.camp).serializable_hash
  end
end

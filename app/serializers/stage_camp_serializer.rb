class StageCampSerializer
  include JSONAPI::Serializer

  attribute :stage do |object|
    object.stage
  end

  attribute :camp do |object|
    object.camp
  end
end

class ActiveCarnivalSerializer
  include JSONAPI::Serializer

  attributes :current_stage

  attribute :carnival do |_object|
    CarnivalDetailSerializer.new(Carnival.active).serializable_hash
  end

  attribute :active_camp do |object|
    UserStageScheduleSerializer.new(object.active_camp).serializable_hash
  end
end

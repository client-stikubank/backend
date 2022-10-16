module Admin
  class UserStageScheduleSerializer
    include JSONAPI::Serializer

    attributes :status, :created_at, :updated_at

    attribute :user do |object|
      UserSerializer.new(object.user).serializable_hash
    end

    attribute :stage_camp do |object|
      StageCampSerializer.new(object.stage_camp).serializable_hash
    end

    attribute :stage_camp_schedule do |object|
      object.stage_camp_schedule
    end
  end
end
# frozen_string_literal: true

require "dry/monads/do"

class UserStageScheduleService::Create
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  attr_reader :params, :user

  def initialize(params:, user:)
    @params = params
    @user = user
  end

  def call
    ActiveRecord::Base.transaction(requires_new: true) do
      yield call_create_record
    end
  end

  private

  def call_create_record
    schedule_id = params[:stage_camp_schedule_id]
    record = user ? user.user_stage_schedules.new(stage_camp_schedule_id: schedule_id) : UserStageSchedule.new(params)

    if record.save
      Success(record)
    else
      Failure([:error, record.errors])
    end
  end
end

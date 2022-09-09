# frozen_string_literal: true

module Admin
  class StageCampSchedulesController < AdminController
    before_action :set_stage_camp_schedule, only: %i[update destroy]

    def index
      stage_camp_schedules = StageCampScheduleService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @stage_camp_schedules = stage_camp_schedules.success
      serialize!(StageCampSchedule, @stage_camp_schedules, paginate(@stage_camp_schedules))
    end

    def create
      stage_camp_schedule = StageCampScheduleService::Create.new(params: stage_camp_schedule_params).call
      stage_camp_schedule ? serialize!(StageCampSchedule, stage_camp_schedule) : error!(stage_camp_schedule.failure[1])
    end

    def update
      stage_camp_schedule = StageCampScheduleService::Update.new(
        params: stage_camp_schedule_params,
        record: @stage_camp_schedule
      ).call
      stage_camp_schedule ? serialize!(StageCampSchedule, stage_camp_schedule) : error!(stage_camp_schedule.failure[1])
    end

    def destroy
      stage_camp_schedule = StageCampScheduleService::Destroy.new(record: @stage_camp_schedule).call
      stage_camp_schedule ? serialize!(StageCampSchedule, stage_camp_schedule) : error!(stage_camp_schedule.failure[1])
    end

    private

    def stage_camp_schedule_params
      params.require(:stage_camp_schedule).permit(:stage_camp_id, :started_at, :time_start, :time_end, :quota)
    end

    def set_stage_camp_schedule
      @stage_camp_schedule = StageCampSchedule.find_by(id: params[:id])
    end
  end
end

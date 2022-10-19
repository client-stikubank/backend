# frozen_string_literal: true

module Admin
  class UserStageSchedulesController < AdminController
    before_action :set_user_stage_schedule, only: %i[show update]

    def index
      user_stage_schedules = UserStageScheduleService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @user_stage_schedules = user_stage_schedules.success
      serialize!('Admin::UserStageSchedule', @user_stage_schedules, paginate(@user_stage_schedules))
    end

    def show
      @user_stage_schedule ? serialize!('Admin::UserStageSchedule', @user_stage_schedule) : error!(I18n.t('c.errors.data_not_found'))
    end

    def update
      user_stage_schedule = UserStageScheduleService::Update.new(params: user_stage_schedule_params, record: @user_stage_schedule).call
      user_stage_schedule ? serialize!('Admin::UserStageSchedule', user_stage_schedule) : error!(user_stage_schedule.failure[1])
    end

    private

    def user_stage_schedule_params
      params.require(:user_stage_schedule).permit(:stage_camp_schedule_id)
    end

    def set_user_stage_schedule
      @user_stage_schedule = UserStageSchedule.find_by(id: params[:id])
    end
  end
end

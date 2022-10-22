module Api
  module V1
    class UserStageSchedulesController < MobileController
      def index
        user_stage_schedules = UserStageScheduleService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object
        )

        @user_stage_schedules = current_user.user_stage_schedules
        serialize!('UserStageSchedule', @user_stage_schedules, paginate(@user_stage_schedules))
      end

      def create
        user_stage_schedule = UserStageScheduleService::Create.new(
          params: user_stage_schedule_params,
          user: current_user
        ).call
        user_stage_schedule ? serialize!(UserStageSchedule, user_stage_schedule) : error!(user_stage_schedule.failure[1])
      end

      private

      def user_stage_schedule_params
        params.require(:user_stage_schedule).permit(:stage_camp_schedule_id)
      end
    end
  end
end

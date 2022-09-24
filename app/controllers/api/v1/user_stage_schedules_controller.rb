module Api
  module V1
    class UserStageScheduleController < MobileController
      def create
        user_stage_schedule = UserStageScheduleService::Create.new(
          params: user_stage_schedule_params,
          user: current_user
        ).call
        user_stage_schedule ? serialize!(UserStageSchedule, user_stage_schedule) : error!(user_stage_schedule.failure[1])
      end

      private

      def user_stage_schedule_params
        params.require(:user_stage_schedule).permit(:stage_schedule_id)
      end
    end
  end
end

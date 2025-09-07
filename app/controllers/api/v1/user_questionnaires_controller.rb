module Api
  module V1
    class UserQuestionnairesController < MobileController
      def create
        result = UserQuestionnaireService::Create.new(
          params: user_questionnaire_params,
          user: current_user
        ).call

        if result.success?
          if result.value.is_a?(Array) && result.value[0] == :wrong_answer
            render json: { message: result.value[1], status: "wrong_answer" }, status: :ok
          else
            serialize!(UserQuestionnaire, result.value)
          end
        else
          error!(result.failure[1])
        end
      end

      private

      def user_questionnaire_params
        params.require(:user_questionnaire).permit(:questionnaire_id, :answer)
      end
    end
  end
end

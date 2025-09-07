module Api
  module V1
    class UserQuestionnairesController < MobileController
      def create
        result = UserQuestionnaireService::Create.new(
          params: user_questionnaire_params,
          user: current_user
        ).call

        if result.is_a?(Array) && result[0] == :wrong_answer
          render json: { message: result[1], status: "wrong_answer" }, status: :ok
        elsif result.instance_of?(UserQuestionnaire)
          serialize!(UserQuestionnaire, result)
        elsif result.respond_to?(:failure)
          error!(result.failure[1])
        else
          error!("Unexpected response from service")
        end
      end

      private

      def user_questionnaire_params
        params.require(:user_questionnaire).permit(:questionnaire_id, :answer)
      end
    end
  end
end

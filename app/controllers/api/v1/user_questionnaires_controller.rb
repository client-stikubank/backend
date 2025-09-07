module Api
  module V1
    class UserQuestionnairesController < MobileController
      def create
        user_questionnaire = UserQuestionnaireService::Create.new(
          params: user_questionnaire_params,
          user: current_user
        ).call

        user_questionnaire ? serialize!(UserQuestionnaire, user_questionnaire) : error!(user_questionnaire.failure[1])
      end

      private

      def user_questionnaire_params
        params.require(:user_questionnaire).permit(:questionnaire_id, :answer)
      end
    end
  end
end

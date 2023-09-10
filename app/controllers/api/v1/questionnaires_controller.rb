module Api
  module V1
    class QuestionnairesController < MobileController
      before_action :set_questionnaire, only: :show
      before_action :check_attempt!, only: :show

      def show
        @questionnaire ? serialize!(Questionnaire, @questionnaire) : error!(I18n.t('c.errors.data_not_found'))
      end

      private

      def set_questionnaire
        @questionnaire = Questionnaire.available.active.find_by(id: params[:id])
      end

      def check_attempt!
        user_questionnaire = @questionnaire.users.find_by(id: current_user.id)

        if user_questionnaire.present?
          render json: { message: 'Anda sudah menjawab pertanyaan ini!' }
        end
      end
    end
  end
end

# frozen_string_literal: true

module Admin
  class QuestionnairesController < AdminController
    before_action :set_questionnaire, only: %i[show update destroy]

    def index
      questionnaires = QuestionnaireService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @questionnaires = questionnaires.success
      serialize!(Questionnaire, @questionnaires, paginate(@questionnaires))
    end

    def create
      questionnaire = QuestionnaireService::Create.new(params: questionnaire_params).call

      questionnaire.instance_of?(Questionnaire) ? serialize!(Questionnaire, questionnaire) : error!(questionnaire.failure[1])
    end

    def update
      questionnaire = QuestionnaireService::Update.new(params: questionnaire_params, record: @questionnaire).call

      questionnaire.instance_of?(Questionnaire) ? serialize!(Questionnaire, questionnaire) : error!(questionnaire.failure[1])
    end

    def show
      @questionnaire ? serialize!(Questionnaire, @questionnaire) : error!(I18n.t('c.errors.data_not_found'))
    end

    def destroy
      questionnaire = QuestionnaireService::Destroy.new(record: @questionnaire).call

      questionnaire.instance_of?(Questionnaire) ? destroyed! : error!(questionnaire.failure[1])
    end

    private

    def questionnaire_params
      params.require(:questionnaire).permit(:question, :status, :start_date, :end_date, answers: [], reward_amount: [])
    end

    def set_questionnaire
      @questionnaire = Questionnaire.find_by(id: params[:id])
    end
  end
end

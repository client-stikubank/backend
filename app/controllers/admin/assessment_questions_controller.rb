# frozen_string_literal: true

module Admin
  class AssessmentQuestionsController < AdminController
    before_action :set_assessment_question, only: %i[update destroy]

    def index
      assessment_questions = AssessmentQuestionService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @assessment_questions = assessment_questions.success
      serialize!(AssessmentQuestion, @assessment_questions, paginate(@assessment_questions))
    end

    def create
      assessment_question = AssessmentQuestionService::Create.new(params: assessment_question_params).call
      assessment_question ? serialize!(AssessmentQuestion, assessment_question) : error!(assessment_question.failure[1])
    end

    def update
      assessment_question = AssessmentQuestionService::Update.new(params: assessment_question_params, record: @assessment_question).call
      assessment_question ? serialize!(AssessmentQuestion, assessment_question) : error!(assessment_question.failure[1])
    end

    def destroy
      assessment_question = AssessmentQuestionService::Destroy.new(record: @assessment_question).call
      assessment_question ? serialize!(AssessmentQuestion, assessment_question) : error!(assessment_question.failure[1])
    end

    private

    def assessment_question_params
      params.require(:assessment_question).permit(
        :question, :choice_1_text, :choice_2_text, :choice_1_image, :choice_2_image,
        :choice_1_type, :choice_2_type, :status
      )
    end

    def set_assessment_question
      @assessment_question = AssessmentQuestion.find_by(id: params[:id])
    end
  end
end

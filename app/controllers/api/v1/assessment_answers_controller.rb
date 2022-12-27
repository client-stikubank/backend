module Api
  module V1
    class AssessmentAnswersController < MobileController
      before_action :set_assessment, only: :update

      def update
        assessment = AssessmentAnswerService::Update.new(params: assessment_answer_params, record: @assessment).call

        assessment.instance_of?(AssessmentAnswer) ? serialize!(AssessmentAnswer, @assessment) : error!(assessment.failure[1])
      end

      private

      def assessment_answer_params
        params.require(:assessment_answer).permit(:answer)
      end

      def set_assessment
        @assessment = AssessmentAnswer.find(params[:id])
      end
    end
  end
end

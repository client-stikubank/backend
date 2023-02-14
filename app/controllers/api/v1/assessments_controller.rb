module Api
  module V1
    class AssessmentsController < MobileController
      before_action :set_assessment, only: :update

      def index
        assessments = AssessmentService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object,
          record: Assessment.completed.where.not(user_id: current_user.id).limit(20)
        )

        @assessments = assessments.success
        serialize!('Assessment', @assessments, paginate(@assessments))
      end

      def create
        assessment = AssessmentService::Create.new(
          params: assessment_params,
          user: current_user
        ).call
        assessment ? serialize!(Assessment, assessment) : error!(assessment.failure[1])
      end

      def update
        assessment = AssessmentService::Update.new(params: assessment_params, record: @assessment).call

        assessment.instance_of?(Assessment) ? serialize!(Assessment, @assessment) : error!(assessment.failure[1])
      end

      private

      def assessment_params
        params.require(:assessment).permit(:programmable_id, :status, :completed_at, assessment_answers_attributes: [:index_order, :assessment_question_id, :user_id])
      end

      def set_assessment
        @assessment = Assessment.find(params[:id])
      end
    end
  end
end

module Api
  module V1
    class AssessmentsController < MobileController
      before_action :set_assessment, only: :update

      def index
        assessments = AssessmentService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object,
          record: current_user.assessments
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
        params.require(:assessment).permit(:programmable_id, :status, :completed_at)
      end

      def set_assessment
        @assessment = Assessment.find(params[:assessment_id])
      end
    end
  end
end

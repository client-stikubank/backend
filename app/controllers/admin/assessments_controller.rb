# frozen_string_literal: true

module Admin
  class AssessmentsController < AdminController
    def index
      assessments = AssessmentService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @assessments = assessments.success
      serialize!(Assessment, @assessments, paginate(@assessments))
    end
  end
end

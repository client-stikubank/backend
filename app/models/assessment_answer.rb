# frozen_string_literal: true

class AssessmentAnswer < ApplicationRecord
  belongs_to :assessment
  belongs_to :assessment_question
end

# frozen_string_literal: true

class AssessmentAnswer < ApplicationRecord
  enum answer: { one: 1, two: 2 }

  belongs_to :assessment
  belongs_to :assessment_question
end

# frozen_string_literal: true

class AssessmentAnswer < ApplicationRecord
  default_scope { order(index_order: :asc) }

  enum answer: { one: 1, two: 2 }

  belongs_to :assessment
  belongs_to :assessment_question

  scope :unanswered, -> { where(answer: nil) }
end

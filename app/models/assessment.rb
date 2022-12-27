# frozen_string_literal: true

class Assessment < ApplicationRecord
  enum status: { pending: 0, completed: 1 }

  belongs_to :programmable, polymorphic: true
  belongs_to :user

  has_many :assessment_answers, dependent: :destroy

  before_save :set_assessment_answers, if: :new_record?

  def set_assessment_answers
    AssessmentQuestion.active.order('RANDOM()').each_with_index do |question, index|
      assessment_answers.build(
        index_order: index + 1,
        assessment_question_id: question.id,
        user_id:
      )
    end
  end
end

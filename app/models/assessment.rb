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

  def choice_types_map
    return [] if assessment.pending?

    types = assessment_answers.includes(:assessment_question).map do |answer|
      answer.one? ? answer.assessment_question.choice_1_type : answer.assessment_question.choice_2_type
    end

    types.group_by { |a| a }.map { |key, values| Hash["#{key}": values.size] }.reduce(:merge)
  end
end

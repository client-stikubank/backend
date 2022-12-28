# frozen_string_literal: true

class Assessment < ApplicationRecord
  enum status: { pending: 0, completed: 1 }

  belongs_to :programmable, polymorphic: true
  belongs_to :user
  belongs_to :personality, optional: true

  has_many :assessment_answers, dependent: :destroy

  before_save :set_assessment_answers, if: :new_record?
  before_update :set_results, if: :status_changed?

  def choice_types
    return if status == 'pending'

    types = assessment_answers.includes(:assessment_question).map do |answer|
      answer.one? ? answer.assessment_question.choice_1_type : answer.assessment_question.choice_2_type
    end

    types.group_by { |a| a }.map { |key, values| Hash["#{key}": values.size] }.reduce(:merge)
  end

  def set_assessment_answers
    AssessmentQuestion.active.order('RANDOM()').each_with_index do |question, index|
      assessment_answers.build(
        index_order: index + 1,
        assessment_question_id: question.id,
        user_id:
      )
    end
  end

  def set_results
    code = []
    results = choice_types

    return if results.blank?

    code << (results[:introvert].to_i > results[:extrovert].to_i ? 'I' : 'E')
    code << (results[:sensing].to_i > results[:intuition].to_i ? 'S' : 'N')
    code << (results[:thinking].to_i > results[:feeling].to_i ? 'T' : 'F')
    code << (results[:judging].to_i > results[:perceiving].to_i ? 'J' : 'P')

    self.results = results.to_json
    self.personality = Personality.find_by(code: code.join(''))
  end
end

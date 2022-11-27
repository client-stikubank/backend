# frozen_string_literal: true

class AssessmentQuestion < ApplicationRecord
  mount_uploader :choice_1_image, ImageUploader
  mount_uploader :choice_2_image, ImageUploader

  enum choice_1_type: {
    introvert: 'introvert', extrovert: 'extrovert', sensing: 'sensing',
    intuition: 'intuition', thinking: 'thinking', feeling: 'feeling',
    judging: 'judging', perceiving: 'perceiving'
  }, _prefix: :choice_1
  enum choice_2_type: {
    introvert: 'introvert', extrovert: 'extrovert', sensing: 'sensing',
    intuition: 'intuition', thinking: 'thinking', feeling: 'feeling',
    judging: 'judging', perceiving: 'perceiving'
  }, _prefix: :choice_2
  enum status: { inactive: 0, active: 1 }
end

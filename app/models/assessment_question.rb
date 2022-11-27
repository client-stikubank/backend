# frozen_string_literal: true

class AssessmentQuestion < ApplicationRecord
  mount_uploader :choice_1_image, ImageUploader
  mount_uploader :choice_2_image, ImageUploader

  enum status: { inactive: 0, active: 1 }
end

# frozen_string_literal: true

class AssessmentQuestion < ApplicationRecord
  mount_uploader :choice_1_image, ImageUploader
  mount_uploader :choice_2_image, ImageUploader
end

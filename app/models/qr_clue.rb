# frozen_string_literal: true

class QrClue < ApplicationRecord
  mount_uploader :image, ImageUploader
end

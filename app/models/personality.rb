# frozen_string_literal: true

class Personality < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, presence: true, uniqueness: true
  validates :code, length: {
    minimum: 4,
    maximum: 4
  }
end

# frozen_string_literal: true

class City < ApplicationRecord
  belongs_to :province

  has_many :user_profiles

  validates :name, presence: true

  acts_as_paranoid
end

# frozen_string_literal: true

class Event < ApplicationRecord
  mount_uploader :image, ImageUploader

  enum status: { inactive: 0, active: 1 }

  has_many :user_events, dependent: :destroy
  has_many :sold_events, -> { where(status: [1, 2]) }, class_name: 'UserEvent'

  validates :title, presence: true, uniqueness: true
  validates :reward_amount, length: {
    minimum: 4,
    maximum: 4
  }

  acts_as_paranoid

  def out_of_stock?
    user_events.size >= quantity
  end

  def book_available?
    active? && quantity.positive? && !out_of_stock?
  end
end

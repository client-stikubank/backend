# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  enum status: { inactive: 0, active: 1 }

  has_many :user_questionnaires, dependent: :destroy
  has_many :users, through: :user_questionnaires

  validates :reward_amount, length: {
    minimum: 4,
    maximum: 4
  }

  scope :available, -> {
    where('start_date <= ?', Time.zone.now.to_date).where('end_date >= ?', Time.zone.now.to_date)
  }

  acts_as_paranoid
end

# frozen_string_literal: true

class StageCampSchedule < ApplicationRecord
  belongs_to :stage_camp
  has_many :user_stage_schedules
  has_many :users, through: :user_stage_schedules

  scope :upcoming, -> { where('started_at > ?', Time.zone.now) }

  validate :check_quota

  def joined_count
    user_stage_schedules.not_rejected.count
  end

  def is_full?
    joined_count >= quota 
  end

  private

  def check_quota
    return unless is_full?

    errors.add(:base, I18n.t('errors.messages.more_than_joined_count', count: joined_count))
  end
end

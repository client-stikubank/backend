# frozen_string_literal: true

class UserStageSchedule < ApplicationRecord
  ACTIVE_STATUSES = [:pending, :confirmed]

  enum status: { pending: 0, confirmed: 1, finish: 2, rejected: 3, absent: 4 }

  belongs_to :user
  belongs_to :stage_camp_schedule

  has_one :stage_camp, through: :stage_camp_schedule
  has_one :stage, through: :stage_camp
  has_one :carnival, through: :stage

  validate :check_quota
  validate :check_status

  scope :current, -> { joins(:carnival).where(carnival: { status: :active }) }
  scope :active, -> { current.where(status: ACTIVE_STATUSES) }

  private

  def check_quota
    return unless stage_camp_schedule.is_full?

    errors.add(:base, I18n.t('errors.messages.quota_is_full'))
  end

  def check_status
    return unless user.active_camp

    errors.add(:base, I18n.t('errors.message.has_active_camp'))
  end
end

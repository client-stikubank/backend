# frozen_string_literal: true

class StageCampSchedule < ApplicationRecord
  ACTIVE_STATUSES = [:pending, :reminded, :claim_time].freeze

  enum status: { pending: 0, reminded: 1, claim_time: 2, completed: 3, closed: 4 }
  enum learning_type: { offline: 0, online: 1 }

  belongs_to :stage_camp
  has_many :user_stage_schedules, dependent: :destroy
  has_many :users, through: :user_stage_schedules

  scope :upcoming, -> { where('started_at >= ?', Time.zone.now.to_date) }

  validate :check_quota

  def joined_count
    user_stage_schedules.not_rejected.count
  end

  def full?
    joined_count >= quota
  end

  def started_datetime
    times = time_start.split(':').map(&:to_i)

    started_at.in_time_zone.change(hour: times[0], min: times[1])
  end

  def ended_datetime
    times = time_end.split(':').map(&:to_i)

    started_at.in_time_zone.change(hour: times[0], min: times[1])
  end

  private

  def check_quota
    return unless quota < joined_count

    errors.add(:base, I18n.t('errors.messages.more_than_joined_count', count: joined_count))
  end
end

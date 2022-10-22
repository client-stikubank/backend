# frozen_string_literal: true

class UserStageSchedule < ApplicationRecord
  ACTIVE_STATUSES = [:pending, :confirmed]

  enum status: { pending: 0, confirmed: 1, finish: 2, rejected: 3, absent: 4 }

  belongs_to :user
  belongs_to :stage_camp_schedule

  has_one :stage_camp, through: :stage_camp_schedule
  has_one :camp, through: :stage_camp
  has_one :stage, through: :stage_camp
  has_one :carnival, through: :stage
  has_many :rewards, foreign_key: :activitable_id

  validate :check_quota
  validate :check_status, on: :create

  scope :current, -> {
    joins(:carnival).where(
      carnival: { status: :active },
    )
  }
  scope :active, -> {
    current.joins(:stage_camp_schedule).where(
      status: ACTIVE_STATUSES,
      stage_camp_schedule: { status: StageCampSchedule::ACTIVE_STATUSES }
    )
  }
  scope :history, -> { not_pending.not_confirmed }

  def finish_and_claim!
    self.finish!

    Coin.each_with_index do |coin, index|
      next if camp.reward_amount[index] === 0

      stock = Stock.find_by(coin: coin)
      wallet = user.wallets.find_by(coin: coin)

      Reward.create!(
        amount: camp.reward_amount[index],
        coin: coin,
        reward_type: :join_camp,
        activitable: self,
        from: stock,
        to: coin
      )
    end
  end

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

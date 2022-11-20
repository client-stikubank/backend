# frozen_string_literal: true

class CarnivalGift < ApplicationRecord
  enum status: { inactive: 0, active: 1 }

  belongs_to :carnival
  belongs_to :gift

  has_many :user_carnival_gifts, dependent: :destroy
  has_many :redeemed_gifts, -> { where(status: [0, 1]) }, class_name: 'UserCarnivalGift'
  has_many :cancelled_gifts, -> { cancelled }, class_name: 'UserCarnivalGift'

  validate :check_redeemed_gifts

  def out_of_stock?
    redeemed_gifts.size >= quantity
  end

  def redeem_available?
    active? && quantity.positive? && !out_of_stock?
  end

  private

  def check_redeemed_gifts
    return unless quantity < redeemed_gifts.size

    errors.add(:base, I18n.t('errors.messages.more_than_redeemed_gifts', count: redeemed_gifts.size))
  end
end

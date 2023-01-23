# frozen_string_literal: true

class UserCarnivalGift < ApplicationRecord
  enum status: { redeemed: 0, paid: 1, cancelled: 2 }

  belongs_to :user
  belongs_to :carnival_gift

  has_one :gift, through: :carnival_gift
  has_one :carnival, through: :carnival_gift

  has_many :user_carnival_gifts, dependent: :destroy

  validate :redeem_validation, on: :create

  after_update :check_paid_gift

  class << self
    def sum_gift_price
      prices = includes(:gift).redeemed.map { |user_carnival_gift| user_carnival_gift.gift.reward_amount }
      prices.transpose.map(&:sum)
    end
  end

  private

  def check_paid_gift
    return unless saved_change_to_status? && status == 'paid'

    Coin.all.each_with_index do |coin, index|
      next if gift.reward_amount[index].zero?

      stock = Stock.find_by(coin:)
      wallet = user.wallets.find_by(coin:)

      Redeem.create!(
        amount: gift.reward_amount[index],
        coin:,
        redeem_type: :gift,
        kindable: self,
        from: wallet,
        to: stock
      )
    end
  end

  def redeem_validation
    errors.add(:base, I18n.t('errors.messages.gift_issue')) unless carnival_gift.redeem_available?

    balance_x_amount = [user.remaining_balance, gift.reward_amount]
    remaining_balance = balance_x_amount.transpose.map { |balance| balance.reduce(:-) }

    return if remaining_balance.all? { |balance| balance >= 0 }

    errors.add(:base, I18n.t('errors.messages.insufficient_balance'))
  end
end

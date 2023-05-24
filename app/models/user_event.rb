# frozen_string_literal: true

class UserEvent < ApplicationRecord
  enum status: { paid: 0, used: 1 }

  belongs_to :user
  belongs_to :event

  validate :book_validation, on: :create

  after_create :check_paid_event

  private

  def check_paid_event
    Coin.all.each_with_index do |coin, index|
      next if event.reward_amount[index].zero?

      stock = Stock.find_by(coin:)
      wallet = user.wallets.find_by(coin:)

      Redeem.create!(
        amount: event.reward_amount[index],
        coin:,
        redeem_type: :event,
        kindable: self,
        from: wallet,
        to: stock
      )
    end
  end

  def book_validation
    errors.add(:base, I18n.t('errors.messages.event_stock_validation')) unless event.book_available?

    balance_x_amount = [user.remaining_balance, event.reward_amount]
    remaining_balance = balance_x_amount.transpose.map { |balance| balance.reduce(:-) }

    return if remaining_balance.all? { |balance| balance >= 0 }

    errors.add(:base, I18n.t('errors.messages.insufficient_balance'))
  end
end

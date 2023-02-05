# frozen_string_literal: true

class UserEvent < ApplicationRecord
  enum status: { booked: 0, paid: 1, used: 2 }

  belongs_to :user
  belongs_to :event

  validate :book_validation, on: :create

  private

  def book_validation
    errors.add(:base, I18n.t('errors.messages.event_stock_validation')) unless event.book_available?

    balance_x_amount = [user.remaining_balance, event.reward_amount]
    remaining_balance = balance_x_amount.transpose.map { |balance| balance.reduce(:-) }

    return if remaining_balance.all? { |balance| balance >= 0 }

    errors.add(:base, I18n.t('errors.messages.insufficient_balance'))
  end
end

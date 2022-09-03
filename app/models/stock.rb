# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :coin

  validate :validate_balance!

  private

  def validate_balance!
    errors.add(:base, I18n.t('errors.messages.greater_than_coin_max_supply')) if balance > coin.max_supply
  end
end

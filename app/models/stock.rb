# frozen_string_literal: true

class Stock < ApplicationRecord
  default_scope { ordered }

  belongs_to :coin
  has_many :transactions, as: :transactable

  scope :ordered, -> { includes(:coin).order('coins.name ASC') }

  validate :validate_balance!

  private

  def validate_balance!
    errors.add(:base, I18n.t('errors.messages.greater_than_coin_max_supply')) if balance > coin.max_supply
  end
end

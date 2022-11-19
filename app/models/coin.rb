# frozen_string_literal: true

class Coin < ApplicationRecord
  default_scope { order(name: :asc) }

  mount_uploader :image, ImageUploader

  enum name: { beryl: 0, ale: 1, jenny: 2, mamo: 3 }

  has_one :stock, dependent: :destroy
  has_many :wallets, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :max_supply, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :check_stock, on: :update

  after_commit :build_stock, :build_wallets, on: :create
  after_commit :update_stock, on: :update

  private

  def check_stock
    return if max_supply > max_supply_was

    errors.add(:base, I18n.t('errors.messages.stock_balance_not_enough')) if stock.balance < (max_supply_was - max_supply)
  end

  def update_stock
    supplies = previous_changes['max_supply']
    return unless supplies

    prev_supply = supplies[0]
    supply = supplies[1]

    if prev_supply > supply
      stock.update(balance: stock.balance - (prev_supply - supply))
    else
      stock.update(balance: stock.balance + (supply - prev_supply))
    end
  end

  def build_stock
    create_stock(balance: max_supply)
  end

  def build_wallets
    User.all.find_each do |user|
      user.wallets.create(coin: self)
    end
  end
end

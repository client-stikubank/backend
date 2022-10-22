# frozen_string_literal: true

class Coin < ApplicationRecord
  default_scope { ordered }

  mount_uploader :image, ImageUploader

  enum name: { mamo: 0, beryl: 1, ale: 2, jenny: 3 }

  has_one :stock, dependent: :destroy
  has_many :wallets, dependent: :destroy

  scope :ordered, -> { in_order_of(:name, %i[beryl ale jenny mamo]) }
  
  validates :name, presence: true, uniqueness: true
  validates :max_supply, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :check_stock, on: :update

  after_commit :build_stock, :build_wallets, on: :create
  after_commit :update_stock, on: :update

  private

  def check_stock
    return if max_supply > max_supply_was

    if stock.balance < (max_supply_was - max_supply)
      errors.add(:base, I18n.t('errors.messages.stock_balance_not_enough'))
    end
  end

  def update_stock
    supplies = previous_changes.dig('max_supply')
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

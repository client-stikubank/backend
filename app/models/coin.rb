# frozen_string_literal: true

class Coin < ApplicationRecord
  mount_uploader :image, ImageUploader

  enum name: %i[mamo beryl ale jenny]
  has_one :stock, dependent: :destroy
  has_many :wallets, dependent: :destroy

  validates :name, uniqueness: true

  after_create :build_stock, :build_wallets

  private

  def build_stock
    create_stock(balance: max_supply)
  end

  def build_wallets
    User.all.each do |user|
      user.wallets.create(coin: self)
    end
  end
end

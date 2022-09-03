# frozen_string_literal: true

class User < ApplicationRecord
  include Authenticable

  enum role: %i[admin user]

  has_many :stage_schedules, through: :user_stage_schedules
  has_many :wallets

  after_create :build_wallets

  private

  def build_wallets
    Coin.all.each do |coin|
      wallets.create(coin: coin)
    end
  end
end

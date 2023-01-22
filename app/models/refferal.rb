# frozen_string_literal: true

class Refferal < ApplicationRecord
  REFFERAL_REWARD_AMOUNT = 1

  belongs_to :user
  belongs_to :refferal, class_name: 'User', foreign_key: :reffered_by_id
  has_many :rewards, foreign_key: :activitable_id

  after_commit :process_refferal_reward, on: :create

  def process_refferal_reward
    stock = Stock.mamo

    [user, refferal].each do |target|
      Reward.create!(
        amount: REFFERAL_REWARD_AMOUNT,
        coin: stock.coin,
        reward_type: :refferal,
        activitable: self,
        from: stock,
        to: target.wallets.mamo
      )
    end
  end
end

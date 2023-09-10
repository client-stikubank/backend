# frozen_string_literal: true

class UserQuestionnaire < ApplicationRecord
  belongs_to :user
  belongs_to :questionnaire

  validates :user_id, uniqueness: { scope: :questionnaire_id }
  
  after_create :claim_reward

  private

  def claim_reward
    Coin.all.each_with_index do |coin, index|
      next if questionnaire.reward_amount[index].zero?

      stock = Stock.find_by(coin:)
      wallet = user.wallets.find_by(coin:)

      Reward.create!(
        amount: questionnaire.reward_amount[index],
        coin:,
        reward_type: :questionnaire,
        activitable: self,
        from: stock,
        to: wallet
      )
    end
  end
end

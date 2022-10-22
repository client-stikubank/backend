# frozen_string_literal: true

module Api
  module V1
    class RewardsController < AdminController
      before_action :set_reward, only: %i[process_transaction]

      def index
        rewards = RewardService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object
        )

        @rewards = rewards.success
        serialize!(Reward, @rewards, paginate(@rewards))
      end

      def process_transaction
        @reward.process_transaction ? serialize!(Reward, @reward) : error!(I18n.t('c.errors.transaction_fail'))
      end

      private

      def set_reward
        @reward = Reward.find_by(id: params[:id])
      end
    end
  end
end

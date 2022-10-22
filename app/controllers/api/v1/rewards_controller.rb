# frozen_string_literal: true

module Api
  module V1
    class RewardsController < MobileController
      def index
        rewards = RewardService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object,
          record: current_user.rewards
        )

        @rewards = rewards.success
        serialize!(Reward, @rewards, paginate(@rewards))
      end
    end
  end
end

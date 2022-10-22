class RewardTransactionWorker
  include Sidekiq::Worker
  sidekiq_options queue: :critical

  def perform(reward_id)
    reward = Reward.find(reward_id)

    begin
      Transaction.sender.create!(sourceable: reward, transactable: reward.from)
      Transaction.receiver.create!(sourceable: reward, transactable: reward.to)
      reward.complete
    end
  end
end

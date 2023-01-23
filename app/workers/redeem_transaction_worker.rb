class RedeemTransactionWorker
  include Sidekiq::Worker
  sidekiq_options queue: :critical, retry: false

  def perform(redeem_id)
    redeem = Redeem.find(redeem_id)

    begin
      ActiveRecord::Base.transaction do
        Transaction.sender.create!(sourceable: redeem, transactable: redeem.from)
        Transaction.receiver.create!(sourceable: redeem, transactable: redeem.to)
        reward.completed!
      end
    rescue ActiveRecord::RecordInvalid
      reward.pending!
    end
  end
end

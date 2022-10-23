# frozen_string_literal: true

class Reward < ApplicationRecord
  default_scope { order(updated_at: :desc) }

  include AASM

  enum reward_type: { join_camp: 0 }
  enum status: { pending: 'pending', processed: 'processed', completed: 'completed'}

  belongs_to :from, class_name: 'Stock'
  belongs_to :to, class_name: 'Wallet'
  belongs_to :coin
  belongs_to :activitable, polymorphic: true
  has_many :transactions, as: :sourceable, dependent: :destroy

  validates :amount, presence: true

  after_commit :process_transaction, on: :create

  def stock_available?
    from.balance > amount
  end

  def process_transaction
    return unless stock_available?
    self.processed!

    RewardTransactionWorker.perform_async(id)
  end
end

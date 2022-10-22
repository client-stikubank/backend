# frozen_string_literal: true

class Reward < ApplicationRecord
  include AASM

  enum reward_type: { join_camp: 0 }

  belongs_to :from, class_name: 'Stock'
  belongs_to :to, class_name: 'Wallet'
  belongs_to :coin
  belongs_to :activitable, polymorphic: true
  has_many :transactions, as: :sourceable, dependent: :destroy

  validates :amount, presence: true

  after_commit :process_transaction, on: :create

  aasm :status do
    state :pending, initial: true
    state :processing, :completed

    event :process do
      transitions from: :pending, to: :processing, guard: :stock_available?
    end

    event :complete do
      transitions from: :processing, to: :completed, guard: :stock_available?
    end

    event :pend do
      transitions from: [:processing, :completed], to: :pending
    end
  end

  def stock_available?
    from.balance > amount
  end

  def process_transaction
    return unless stock_available?
    self.process

    RewardTransactionWorker.perform_async(id)
  end
end

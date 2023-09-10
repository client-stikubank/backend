# frozen_string_literal: true

class Reward < ApplicationRecord
  default_scope { joins(:coin).order(updated_at: :desc) }

  include AASM

  enum reward_type: { join_camp: 0, refferal: 1, questionnaire: 2 }
  enum status: { pending: 'pending', processed: 'processed', completed: 'completed' }

  belongs_to :from, class_name: 'Stock'
  belongs_to :to, class_name: 'Wallet'
  belongs_to :coin
  belongs_to :activitable, polymorphic: true
  has_many :transactions, as: :sourceable, dependent: :destroy

  validates :amount, presence: true

  before_create :default_status
  after_commit :process_transaction, on: :create

  def stock_available?
    from.balance > amount
  end

  def process_transaction
    return unless stock_available?

    processed!
    RewardTransactionWorker.perform_async(id)
  end

  private
  
  def default_status
    self.status = 'pending'
  end
end

# frozen_string_literal: true

class Redeem < ApplicationRecord
  default_scope { joins(:coin).order(updated_at: :desc) }

  enum redeem_type: { gift: 0 }
  enum status: { pending: 'pending', processed: 'processed', completed: 'completed' }

  belongs_to :from, class_name: 'Wallet'
  belongs_to :to, class_name: 'Stock'
  belongs_to :coin
  belongs_to :kindable, polymorphic: true

  has_many   :transactions, as: :sourceable, dependent: :destroy

  validates :amount, presence: true

  after_commit :process_transaction, on: :create

  def balance_available?
    from.balance > amount
  end

  def process_transaction
    return unless balance_available?

    processed!
    RedeemTransactionWorker.perform_async(id)
  end
end

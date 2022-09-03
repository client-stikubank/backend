# frozen_string_literal: true

class Reward < ApplicationRecord
  include AASM

  enum reward_type: %i[join_camp]

  has_many   :transactions, as: :sourceable, dependent: :destroy
  belongs_to :from, class_name: 'Stock'
  belongs_to :to, class_name: 'Wallet'
  belongs_to :coin
  belongs_to :activitable, polymorphic: true

  validates :amount, presence: true

  aasm :status do
    state :pending, initial: true
    state :processing, :completed

    event :process do
      transitions from: :pending, to: :processing, guard: :stock_available?
    end

    event :complete do
      transitions from: :processing, to: :completed, guard: :stock_available?
    end
  end

  def stock_available?
  end
end

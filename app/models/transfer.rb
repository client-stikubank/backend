# frozen_string_literal: true

class Transfer < ApplicationRecord
  has_many   :transactions, as: :sourceable, dependent: :destroy
  belongs_to :from, class_name: 'Wallet'
  belongs_to :to, class_name: 'Wallet'

  validates :amount, presence: true

  before_update :build_transactions

  private

  def build_transactions; end
end

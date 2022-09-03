# frozen_string_literal: true

class Redeem < ApplicationRecord
  has_many   :transactions, as: :sourceable, dependent: :destroy
  belongs_to :from, class_name: 'Wallet'
  belongs_to :to, class_name: 'Stock'

  validates :amount, presence: true
end

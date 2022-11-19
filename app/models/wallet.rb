# frozen_string_literal: true

class Wallet < ApplicationRecord
  default_scope { ordered }

  belongs_to :coin
  belongs_to :user

  has_many :rewards, foreign_key: :to_id, dependent: :destroy

  scope :ordered, -> { includes(:coin).order('coins.name ASC') }
end

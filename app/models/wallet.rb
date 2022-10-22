# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :coin
  belongs_to :user

  has_many :rewards, foreign_key: :to_id
end

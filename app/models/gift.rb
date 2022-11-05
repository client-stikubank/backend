# frozen_string_literal: true

class Gift < ApplicationRecord
  has_many :carnival_gifts, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :reward_amount, length: {
    minimum: 4,
    maximum: 4
  }


  acts_as_paranoid
end

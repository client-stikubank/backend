# frozen_string_literal: true

class CarnivalGift < ApplicationRecord
  belongs_to :gift
  belongs_to :carnival

  has_many :user_carnival_gifts, dependent: :destroy

  enum status: [:inactive, :active], _default: :inactive
end

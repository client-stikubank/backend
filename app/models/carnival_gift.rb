# frozen_string_literal: true

class CarnivalGift < ApplicationRecord
  enum status: [:inactive, :active], _default: :inactive

  belongs_to :carnival
  belongs_to :gift

  has_many :user_carnival_gifts, dependent: :destroy
end

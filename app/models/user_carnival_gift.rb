# frozen_string_literal: true

class UserCarnivalGift < ApplicationRecord
  belongs_to :user
  belongs_to :carnival_gift

  has_many :user_carnival_gifts, dependent: :destroy

  enum status: [:booked, :redeemed], _default: :booked
end

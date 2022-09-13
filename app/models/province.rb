# frozen_string_literal: true

class Province < ApplicationRecord
  has_many :cities, dependent: :destroy

  validates :name, presence: true

  acts_as_paranoid
end

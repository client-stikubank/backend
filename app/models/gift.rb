# frozen_string_literal: true

class Gift < ApplicationRecord
  has_many :carnival_gifts, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  acts_as_paranoid
end

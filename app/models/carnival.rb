# frozen_string_literal: true

class Carnival < ApplicationRecord
  enum status: { inactive: 0, active: 1, finish: 2 }

  has_many :assessments, as: :programmable
  has_many :stages, dependent: :destroy

  after_create :create_stages

  def create_stages
    6.times do |index|
      index += 1
      stages.create!(name: "Level #{index}", level: index)
    end
  end
end

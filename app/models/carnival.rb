# frozen_string_literal: true

class Carnival < ApplicationRecord
  enum status: %i[inactive active finish]

  has_many :assessments, as: :programmable
  has_many :stages

  after_create :create_stages

  def create_stages
    6.times do |index|
      index = index + 1
      stages.create!(name: "Level #{index}", level: index)
    end
  end
end

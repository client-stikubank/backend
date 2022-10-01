# frozen_string_literal: true

class Carnival < ApplicationRecord
  enum status: { inactive: 0, active: 1, finish: 2 }

  has_many :assessments, as: :programmable
  has_many :stages, dependent: :destroy

  has_many :stage_camps, through: :stages
  has_many :stage_camp_schedules, through: :stage_camps
  has_many :user_stage_schedules, through: :stage_camp_schedules

  after_create :create_stages

  def create_stages
    6.times do |index|
      index += 1
      stages.create!(name: "Level #{index}", level: index)
    end
  end

  def self.active
    where(status: 1).first
  end

  def activate!
    return self if self.active?

    Carnival.active&.inactive!
    self.update(status: :active)
  end
end

# frozen_string_literal: true

class StageCampSchedule < ApplicationRecord
  belongs_to :stage_camp
  has_many :users, through: :user_stage_schedules
end

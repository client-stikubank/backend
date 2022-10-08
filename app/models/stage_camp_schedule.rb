# frozen_string_literal: true

class StageCampSchedule < ApplicationRecord
  belongs_to :stage_camp
  has_many :user_stage_schedules
  has_many :users, through: :user_stage_schedules

  def quota_available?
    user_stage_schedules.count < quota 
  end
end

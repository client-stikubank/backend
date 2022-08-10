# frozen_string_literal: true

class StageSchedule < ApplicationRecord
  belongs_to :stage_camp
  has_many :users, through: :user_stage_schedules
end

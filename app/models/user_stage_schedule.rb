# frozen_string_literal: true

class UserStageSchedule < ApplicationRecord
  belongs_to :user
  belongs_to :stage_camp_schedule

  has_one :stage_camp, through: :stage_camp_schedule
  has_one :stage, through: :stage_camp
  has_one :carnival, through: :stage
end

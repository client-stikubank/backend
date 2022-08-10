# frozen_string_literal: true

class UserStageSchedule < ApplicationRecord
  belongs_to :user
  belongs_to :stage_schedule
end

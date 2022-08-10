# frozen_string_literal: true

class User < ApplicationRecord
  include Authenticable

  enum role: %i[admin user]

  has_many :stage_schedules, through: :user_stage_schedules
end

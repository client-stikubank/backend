# frozen_string_literal: true

class Stage < ApplicationRecord
  default_scope { order(level: :asc) }

  belongs_to :carnival
  has_many :stage_camps
  has_many :camps, through: :stage_camps
end

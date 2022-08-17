# frozen_string_literal: true

class Camp < ApplicationRecord
  enum status: %i[inactive active]

  has_many :stage_camps, dependent: :destroy
  has_many :stages, through: :stage_camps

end

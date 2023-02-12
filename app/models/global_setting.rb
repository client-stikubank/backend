# frozen_string_literal: true

class GlobalSetting < ApplicationRecord
  validates :name, :var, presence: true
  validates :var, uniqueness: true
end

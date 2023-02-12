# frozen_string_literal: true

class GlobalSetting < ApplicationRecord
  validates :name, :code, presence: true
  validates :code, uniqueness: true
end

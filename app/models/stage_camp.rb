# frozen_string_literal: true

class StageCamp < ApplicationRecord
  belongs_to :stage
  belongs_to :camp
end

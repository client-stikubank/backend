# frozen_string_literal: true

class Assessment < ApplicationRecord
  enum status: %i[pending on_progress complete]

  belongs_to :programmable, polymorphic: true
end

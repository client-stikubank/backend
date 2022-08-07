# frozen_string_literal: true

class Carnival < ApplicationRecord
  enum status: %i[inactive active finish]

  has_many :assessments, as: :programmable
end

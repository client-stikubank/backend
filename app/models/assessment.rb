# frozen_string_literal: true

class Assessment < ApplicationRecord
  enum status: { pending: 0, completed: 1 }

  belongs_to :programmable, polymorphic: true
end

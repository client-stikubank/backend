# frozen_string_literal: true

class Assessment < ApplicationRecord
  enum status: { pending: 0, on_progress: 1, complete: 2 }

  belongs_to :programmable, polymorphic: true
end

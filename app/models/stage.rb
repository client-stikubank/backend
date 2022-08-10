# frozen_string_literal: true

class Stage < ApplicationRecord
  default_scope { order(level: :asc) }

  belongs_to :carnival
end

# frozen_string_literal: true

class Camp < ApplicationRecord
  enum status: %i[inactive active]
end

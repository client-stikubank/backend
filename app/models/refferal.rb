# frozen_string_literal: true

class Refferal < ApplicationRecord
  belongs_to :user
  belongs_to :refferal, class_name: 'User', foreign_key: :reffered_by_id
end

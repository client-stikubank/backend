# frozen_string_literal: true

class UserProfile < ApplicationRecord
  belongs_to :user
  validates :phone_number, uniqueness: true
  validates :phone_number, :first_name, :birth_date, presence: true

  def full_name
    full_name = last_name.present? ? "#{first_name} #{last_name}" : first_name

    full_name.titleize
  end
end

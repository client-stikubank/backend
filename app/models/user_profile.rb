# frozen_string_literal: true

class UserProfile < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :city, optional: true

  has_one :parent_information, dependent: :destroy
  has_one :student_information, dependent: :destroy

  validates :phone_number, uniqueness: true
  validates :phone_number, :first_name, :birth_date, presence: true

  accepts_nested_attributes_for :parent_information
  accepts_nested_attributes_for :student_information

  def full_name
    full_name = last_name.present? ? "#{first_name} #{last_name}" : first_name

    full_name.titleize
  end
end

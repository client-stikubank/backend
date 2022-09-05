# frozen_string_literal: true

class Permission < ApplicationRecord
  has_many :role_permissions
  has_many :roles, through: :role_permissions
  validates 'object_type', :action_name, presence: true
  validates 'object_type', uniqueness: { scope: [:action_name] }

  scope :action_names, -> { pluck(:action_name).uniq }
  scope :object_types, -> { pluck(:object_type).uniq }
end

# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  include Authenticable

  has_one  :user_profile, dependent: :destroy
  has_many :stage_schedules, through: :user_stage_schedules
  has_many :wallets

  attr_accessor :generated_password, :role_types

  accepts_nested_attributes_for :user_profile

  after_create :manage_roles
  after_create :build_wallets

  before_save :set_generated_password

  after_commit :send_registration_mail, on: :create

  def role
    roles.first.name.titleize
  end

  def roles=(roles)
    roles.reject(&:blank?)
  end

  def operator?
    has_role?(:operator)
  end

  def superadmin?
    has_role?(:admin)
  end

  def student?
    has_role?(:student)
  end

  def teacher?
    has_role?(:teacher)
  end

  def guardian?
    has_role?(:guardian)
  end

  def admin_user?
    superadmin? || operator?
  end

  def mobile_user?
    student? || teacher? || guardian?
  end

  private

  def build_wallets
    Coin.all.find_each do |coin|
      wallets.create(coin:)
    end
  end

  def manage_roles
    roles = role_types.presence || ['student']
    role_ids = Role.where(name: roles).ids
    update(role_ids:)
  end

  def send_registration_mail
    ApplicationMailer.send_confirmation(id, generated_password).deliver_now
  end

  def assign_default_role
    add_role(:student) if roles.blank?
  end

  def set_generated_password
    self.generated_password = password
  end
end

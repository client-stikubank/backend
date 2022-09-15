# frozen_string_literal: true

class User < ApplicationRecord
  include Authenticable
  rolify

  has_one :refferal, class_name: 'Refferal', foreign_key: :reffered_by_id
  has_one :user_profile, dependent: :destroy

  has_many :refferals
  has_many :stage_schedules, through: :user_stage_schedules
  has_many :wallets

  validate  :check_reffering_code, on: :create, if: Proc.new { reffering_code.present? }

  attr_accessor :generated_password, :role_types, :reffering_code

  accepts_nested_attributes_for :user_profile

  before_save :set_generated_password
  before_save :set_refferal_code

  after_create :manage_roles
  after_create :build_wallets
  after_create :build_refferal, if: Proc.new { reffering_code.present? }

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

  def parent?
    has_role?(:guardian)
  end

  def admin_user?
    superadmin? || operator?
  end

  def mobile_user?
    student? || teacher? || parent?
  end

  private

  def build_wallets
    Coin.all.find_each do |coin|
      wallets.create(coin:)
    end
  end

  def check_reffering_code
    reffering = User.find_by_refferal_code(reffering_code)

    errors.add(:base, I18n.t('errors.messages.invalid_reffering_code')) unless reffering.present?
  end

  def build_refferal
    reffering = User.find_by_refferal_code(reffering_code)

    refferals.create(reffered_by_id:reffering.id ) if reffering.present?
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

  def set_refferal_code
    self.refferal_code = SecureRandom.hex[0, 8].upcase
  end
end

# frozen_string_literal: true

class User < ApplicationRecord
  include Authenticable
  rolify

  has_one :refferal, class_name: 'Refferal', foreign_key: :reffered_by_id
  has_one :user_profile, dependent: :destroy
  has_one :active_camp, -> { active.order(created_at: :desc) }, class_name: 'UserStageSchedule'

  has_many :refferals, dependent: :destroy
  has_many :user_stage_schedules, dependent: :destroy
  has_many :user_carnival_gifts, dependent: :destroy
  has_many :current_schedules, -> { current }, class_name: 'UserStageSchedule'
  has_many :stage_camp_schedules, through: :user_stage_schedules
  has_many :wallets, dependent: :destroy
  has_many :rewards, through: :wallets

  validate :check_reffering_code, on: :create, if: proc { reffering_code.present? }

  attr_accessor :generated_password, :role_types, :reffering_code, :student_information, :parent_information

  accepts_nested_attributes_for :user_profile

  before_save :set_generated_password
  before_save :set_refferal_code

  after_create :manage_roles
  after_create :build_wallets
  after_create :build_refferal, if: proc { reffering_code.present? }

  after_commit :send_registration_mail, on: :create

  def wallet_balance
    wallets.pluck(:balance)
  end

  def remaining_balance
    redeemed_gifts = user_carnival_gifts.redeemed
    return wallet_balance if redeemed_gifts.size.zero?

    [wallet_balance, redeemed_gifts.sum_gift_price].transpose.map do |balance|
      balance.reduce(:-)
    end
  end

  def current_stage
    finished_schedules = current_schedules.finish
    return 1 if finished_schedules.blank?

    stage = finished_schedules.includes(:stage).order('stages.level DESC').first.stage

    (stage&.level || 0) + 1
  end

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

  def speaker?
    has_role?(:speaker)
  end

  def admin_user?
    superadmin? || operator? || speaker?
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
    reffering = User.find_by(refferal_code: reffering_code)

    errors.add(:base, I18n.t('errors.messages.invalid_reffering_code')) if reffering.blank?
  end

  def build_refferal
    reffering = User.find_by(refferal_code: reffering_code)

    refferals.create(reffered_by_id: reffering.id) if reffering.present?
  end

  def manage_roles
    roles = role_types.presence || ['student']
    role_ids = Role.where(name: roles).ids
    update(role_ids:)
  end

  def send_registration_mail
    SendRegistrationMailWorker.perform_async(id, generated_password)
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

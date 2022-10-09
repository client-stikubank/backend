# frozen_string_literal: true

class Camp < ApplicationRecord
  enum status: { inactive: 0, active: 1 }

  belongs_to :speaker, -> { with_role(:speaker) }, class_name: 'User', foreign_key: 'speaker_id'

  has_many :stage_camps, dependent: :destroy
  has_many :stages, through: :stage_camps

  validate :check_speaker

  private

  def check_speaker
    return if speaker.speaker?

    errors.add(:base, I18n.t('errors.messages.is_not_speaker'))
  end
end

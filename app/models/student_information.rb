# frozen_string_literal: true

class StudentInformation < ApplicationRecord
  belongs_to :user_profile

  enum education_status: [:sd, :smp, :sma, :third_diploma, :fourth_diploma, :first_master, :second_master, :third_master], _default: :sma

  def education_status_name
    case education_status
    when 'sd'
      'SD'
    when 'smp'
      'SMP'
    when 'sma'
      'SMA'
    when 'third_diploma'
      'D3'
    when 'fourth_diploma'
      'D4'
    when 'first_master'
      'S1'
    when 'second_master'
      'S2'
    else
      'S3'
    end
  end
end

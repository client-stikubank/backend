# frozen_string_literal: true

class ParentInformation < ApplicationRecord
  belongs_to :user_profile

  enum graduate_status: [:sd, :smp, :sma, :third_diploma, :fourth_diploma, :first_master, :second_master, :third_master], _default: :sma
  enum salary_level: [:under_three, :under_seven, :under_ten, :under_fifteen, :under_twenty_five, :pass_twenty_five], _default: :under_three

  def graduate_status_name
    case graduate_status
    when 'sd'
      'SD'
    when 'smp'
      'SMP'
    when 'sma'
      'SMA/SMK'
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

  def salary_range
    case salary_level
    when 'under_three'
      'dibawah Rp. 3.000.000,-'
    when 'under_seven'
      'Rp. 3.000.000,- s/d Rp. 7.000.000,-'
    when 'under_ten'
      'Rp. 7.000.000,- s/d Rp. 10.000.000,-'
    when 'under_fifteen'
      'Rp. 10.000.000,- s/d Rp. 15.000.000,-'
    when 'under_twenty_five'
      'Rp. 15.000.000,- s/d Rp. 25.000.000,-'
    else
      'diatas Rp. 25.000.000,-'
    end
  end
end

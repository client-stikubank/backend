class CampReminderWorker
  include Sidekiq::Worker

  def perform
    schedules = StageCampSchedule.includes(:users, :camp, :stage).upcoming.pending

    schedules.each do |schedule|
      if schedule.online?
        time_now = Time.zone.now
        time_diff = (schedule.started_datetime - time_now) / 1.hour

        next unless time_diff <= 1
      else
        next unless schedule.started_at == Date.today
      end

      unless schedule.joined_count > 0
        schedule.closed!
        next
      end

      schedule.transaction do
        phone_numbers = schedule.users.includes(:user_profile).pluck('user_profiles.phone_number')

        if schedule.online?
          schedule.reminded!
          finish_time = ((schedule.ended_datetime - Time.zone.now) / 1.minute).round
          ClaimScheduleWorker.perform_in(finish_time.minutes, schedule.id)

          start_time = ((schedule.started_datetime - Time.zone.now) / 1.minute).round
          AbsentUserWorker.perform_in(start_time.minutes, schedule.id)

          if Rails.env.staging? || Rails.env.production?
            messages = "Hai Youthcampers!\nPelatihan kamu sebentar lagi akan dimulai nih.\nPastikan kamu hadir dan konfirmasi kehadiran di Youthcamp Apps ya!\n\n*Pelatihan:*\n#{schedule.stage.name} - Level #{schedule.stage.level}\n#{schedule.camp.title}\n#{I18n.l(schedule.started_at)}\n#{schedule.time_start} - #{schedule.time_end}\n\n*Link Pelatihan:*\n#{schedule.link}"
            SendWhatsappWorker.perform_async(phone_numbers, messages, 'broadcast')
          end
        else
          schedule.claim_time!
          AbsentUserWorker.perform_at((schedule.started_at + 1.days).beginning_of_day, schedule.id)

          if Rails.env.staging? || Rails.env.production?
            messages = "Hai Youthcampers!\nJangan lupa kamu ada jadwal pelatihan hari ini lho.\nPastikan kamu hadir dan konfirmasi kehadiran di Youthcamp Apps ya!\n\n*Pelatihan:*\n#{schedule.stage.name} - Level #{schedule.stage.level}\n#{schedule.camp.title}\n#{I18n.l(schedule.started_at)}\n#{schedule.time_start} - #{schedule.time_end}"
            SendWhatsappWorker.perform_at(schedule.started_at.beginning_of_day + 5.hours, phone_numbers, messages, 'broadcast')
          end
        end
      end
    end
  end
end

class CampReminderWorker
  include Sidekiq::Worker

  def perform
    schedules = StageCampSchedule.includes(:users).upcoming.pending
    schedules.each do |schedule|
      time_now = Time.zone.now
      time_diff = (schedule.started_datetime - time_now) / 1.hour

      next unless time_diff <= 1

      unless schedule.joined_count > 0
        schedule.closed!
        next
      end

      schedule.transaction do
        phone_numbers = schedule.users.includes(:user_profile).pluck('user_profiles.phone_number')
        schedule.reminded!
        
        finish_time = ((schedule.ended_datetime - Time.zone.now) / 1.minute).round
        ClaimScheduleWorker.perform_in(finish_time.minutes, schedule.id, phone_numbers)

        start_time = ((schedule.started_datetime - Time.zone.now) / 1.minute).round
        AbsentUserWorker.perform_in(start_time.minutes, schedule.id, phone_numbers)

        if Rails.env.staging? || Rails.env.production?
          messages = "Hallo Youthcampers,\nPelatihan kamu sebentar lagi akan dimulai nih.\nPastikan kamu hadir dan konfirmasi kehadiran di Youthcamp Apps ya!\n\n*Pelatihan:*\n#{schedule.stage_camp.stage.name} - Level #{schedule.stage_camp.stage.level}\n#{schedule.stage_camp.camp.title}\n#{I18n.l(schedule.started_at)}\n#{schedule.time_start} - #{schedule.time_end}\n\n*Link Pelatihan:*\n#{schedule.link}"
          SendWhatsappWorker.perform_async(phone_numbers, messages, 'broadcast')
        end
      end
    end
  end
end

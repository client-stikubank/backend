class ClaimScheduleWorker
  include Sidekiq::Worker
  sidekiq_options queue: :critical

  def perform(schedule_id, phone_numbers)
    schedule = StageCampSchedule.find(schedule_id)
    schedule.transaction do
      schedule.claim_time!
      expired_in = schedule.online? (Time.zone.now + 30.minutes) : Time.zone.now.end_of_day
      CompletedScheduleWorker.perform_in(expired_in, schedule_id)
    end
  end
end

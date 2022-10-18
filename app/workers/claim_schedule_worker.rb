class ClaimScheduleWorker
  include Sidekiq::Worker

  def perform(schedule_id, phone_numbers)
    schedule = StageCampSchedule.find(schedule_id)
    schedule.transaction do
      schedule.claim_time!
      CompletedScheduleWorker.perform_in(Time.zone.now + 30.minutes, schedule_id)
    end
  end
end

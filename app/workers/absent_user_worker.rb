class AbsentUserWorker
  include Sidekiq::Worker
  sidekiq_options queue: :critical

  def perform(schedule_id, phone_numbers)
    schedule = StageCampSchedule.find(schedule_id)
    schedule.user_stage_schedules.not_confirmed.update(status: :absent)
  end
end

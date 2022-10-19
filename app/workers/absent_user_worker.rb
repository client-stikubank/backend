class AbsentUserWorker
  include Sidekiq::Worker

  def perform(schedule_id, phone_numbers)
    schedule = StageCampSchedule.find(schedule_id)
    schedule.user_stage_schedules.not_confirmed.update(status: :absent)
  end
end

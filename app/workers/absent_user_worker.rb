class AbsentUserWorker
  include Sidekiq::Worker
  sidekiq_options queue: :critical

  def perform(schedule_id)
    schedule = StageCampSchedule.find(schedule_id)

    schedule.user_stage_schedules.not_finish.not_rejected.update(status: :absent)
  end
end

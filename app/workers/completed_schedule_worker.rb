class CompletedScheduleWorker
  include Sidekiq::Worker
  sidekiq_options queue: :critical

  def perform(schedule_id)
    schedule = StageCampSchedule.find(schedule_id)
    schedule.transaction do
      schedule.completed!
      
      schedule.user_stage_schedules.pending.each do |user_schedule|
        user_schedule.absent!
      end
    end
  end
end

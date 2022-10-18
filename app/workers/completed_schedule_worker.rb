class CompletedScheduleWorker
  include Sidekiq::Worker

  def perform(schedule_id)
    schedule = StageCampSchedule.find(schedule_id)
    schedule.transaction do
      schedule.completed!
      
      schedule.user_stage_schedules.not_finish.not_rejected.each do |user_schedule|
        user_schedule.absent!
      end
    end
  end
end

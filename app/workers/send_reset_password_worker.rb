class SendResetPasswordWorker
  include Sidekiq::Worker
  sidekiq_options queue: :low

  def perform(id)
    ApplicationMailer.reset_password_instructions(id).deliver_now
  end
end

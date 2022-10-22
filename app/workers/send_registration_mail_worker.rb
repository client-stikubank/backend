class SendRegistrationMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: :low

  def perform(id, generated_password)
    ApplicationMailer.send_confirmation(id, generated_password).deliver_now
  end
end

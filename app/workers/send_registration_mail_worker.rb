class SendRegistrationMailWorker
  include Sidekiq::Worker

  def perform(id, generated_password)
    ApplicationMailer.send_confirmation(id, generated_password).deliver_now
  end
end

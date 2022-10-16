class SendWhatsappWorker
  include Sidekiq::Worker

  def perform(phone_numbers, message, type)
    return if phone_numbers.empty?
    #type: ['send, broadcast']
    case type
    when 'broadcast'
      WhatsappService::Broadcast.new(phone_numbers, message).call
    else
      WhatsappService::Send.new(phone_numbers.first, message).call
    end
  end
end

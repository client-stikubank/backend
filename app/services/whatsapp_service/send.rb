# frozen_string_literal: true

require 'dry-initializer'
require "uri"
require "json"
require "net/http"

class WhatsappService::Send
  extend Dry::Initializer

  param  :phone_number
  param  :message

  def call
    url = URI("https://api.watzap.id/v1/send_message")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
      "api_key": ENV['WATZAP_API_KEY'],
      "number_key": ENV['WATZAP_NUMBER_KEY'],
      "phone_no": phone_number,
      "message": message
    })

    response = https.request(request)
    puts response.read_body
  end
end

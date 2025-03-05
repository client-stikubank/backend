CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => ENV['DO_SPACE_ACCESS_KEY'],
      :aws_secret_access_key => ENV['DO_SPACE_SECRET_KEY'],
      :region => 'sgp1',
      :endpoint => 'https://sgp1.digitaloceanspaces.com'
    }
    config.asset_host = "https://#{ENV['DO_SPACE_BUCKET']}.sgp1.digitaloceanspaces.com"
    config.enable_processing = true
    config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
    config.fog_directory = ENV['DO_SPACE_BUCKET']
    config.fog_provider = 'fog/aws'
    config.storage = :fog
  else
    config.enable_processing = false
    config.storage = :file
  end
end

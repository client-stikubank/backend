CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['DO_SPACE_ACCESS_KEY'],
    aws_secret_access_key: ENV['DO_SPACE_SECRET_KEY'],
    region: 'sgp1',
    endpoint: 'sgp1.digitaloceanspaces.com'
  }
  config.fog_directory = 'youthcamp-carrierwave'
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
end

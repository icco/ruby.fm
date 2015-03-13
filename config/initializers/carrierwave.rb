CarrierWave.configure do |config|
  if Rails.env.production? || ENV['USE_AWS']
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_KEY']
    }
    config.fog_directory = ENV['S3_BUCKET']
  else
    config.fog_credentials = {
      provider: 'Local',
      local_root: Rails.root
    }
    config.fog_directory = '/tmp/uploads'
  end
end

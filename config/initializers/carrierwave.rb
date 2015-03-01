# Check out app/uploaders, it modifies these configs at runtime.
CarrierWave.configure do |config|
  if Rails.env.production? || ENV['USE_AWS']
    config.storage = :fog
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_KEY']
    }
    config.fog_directory = ENV['S3_BUCKET']
  else
    config.storage = :file
  end
end

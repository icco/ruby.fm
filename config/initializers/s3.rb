# Be sure to restart your server when you modify this file.
if ENV['AWS_ACCESS_KEY_ID'] and ENV['AWS_SECRET_ACCESS_KEY'] and ENV['S3_BUCKET']
  S3_OPTIONS = {
    :provider => 'AWS',
    :aws_access_key_id =>  ENV['AWS_ACCESS_KEY_ID'].strip.delete('"\''),
    :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'].strip.delete('"\''),
    :region => ENV['S3_REGION'].strip.delete('"\'')
  }
  bucket = ENV['S3_BUCKET'].strip.delete('"\'')
  Rails.logger.debug "S3 Options: #{S3_OPTIONS.inspect}"
  S3 = Fog::Storage.new(S3_OPTIONS)
  S3_DIR = S3.directories.get(bucket)
  if S3_DIR.nil?
    S3_DIR = S3.directories.create(
      :key => bucket,
      :public => true
    )
  end

  if Rails.env.development?
    host = "http://localhost:3000"
  elsif Rails.env.production?
    host = "https://ruby.fm"
  end
  cors =  {
    'CORSConfiguration' => [
      {
        'AllowedOrigin' => host,
        'AllowedMethod' => ['POST', 'GET',  'PUT'],
        'AllowedHeader' => '*',
        'MaxAgeSeconds' => 3000
      }
    ]
  }
  S3.put_bucket_cors(S3_DIR.key, cors)
  Rails.logger.debug("#{S3_DIR.key.inspect} CORS: #{S3.get_bucket_cors(S3_DIR.key).data[:body]}")
else
  Rails.logger.warn("S3 NOT CONFIGURED")
end

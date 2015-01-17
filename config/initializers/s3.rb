# Be sure to restart your server when you modify this file.
options = {
  :provider => 'AWS',
  :aws_access_key_id =>  ENV['AWS_ACCESS_KEY_ID'].strip.delete('"\''),
  :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'].strip.delete('"\''),
  :region => ENV['S3_REGION'].strip.delete('"\''),
}
S3 = Fog::Storage.new(options)
S3_DIR = S3.directories.get(ENV['S3_BUCKET'].strip.delete('"\''))
if S3_DIR.nil?
  S3_DIR = S3.directories.create(
    :key => ENV['S3_BUCKET'].strip.delete('"\''),
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
p S3.get_bucket_cors(S3_DIR.key)

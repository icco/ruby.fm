# Be sure to restart your server when you modify this file.
options = {
  :provider => 'AWS',
  :aws_access_key_id =>  ENV['AWS_ACCESS_KEY_ID'].strip,
  :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'].strip,
}
p options
S3 = Fog::Storage.new(options)
S3_DIR = S3.directories.create(
  :key => ENV['S3_BUCKET'].strip,
  :public => true
)

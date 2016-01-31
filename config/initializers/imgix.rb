module Imgix
  def self.client
    @client ||= Imgix::Client.new(
      host: ENV['IMGIX_URL'],
      secure_url_token: ENV['IMGIX_TOKEN']
    )
  end
end

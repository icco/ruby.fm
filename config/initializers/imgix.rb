module Imgix
  def self.client
    @client ||= Imgix::Client.new(
      host: ENV['IMGIX_URL'],
      token: ENV['IMGIX_TOKEN'],
      secure: true
    )
  end
end

module Imigix
  def self.client
    @client ||= Imigix::Client.new(
      host: ENV['IMGIX_URL'],
      token: ENV['IMGIX_TOKEN'],
      secure: true
    )
  end
end

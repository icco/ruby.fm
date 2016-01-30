class KeenPublisher
  include Sidekiq::Worker

  def perform(channel, attributes={})
    Keen.publish(channel, attributes)
  end
end

class KeenPublisher < ApplicationWorker
  def perform(channel, attributes={})
    Keen.publish(channel, attributes)
  end
end

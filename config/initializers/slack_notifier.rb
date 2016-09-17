module Slack
  def self.notifier
    @notifier ||= Slack::Notifier.new(
      ENV['SLACK_WEBHOOK'],
      channel: '#stats',
      username: 'Benedict',
      icon_emoji: ':egg:'
    )
  end
end

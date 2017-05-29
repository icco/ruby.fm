SitemapGenerator::Sitemap.default_host = "https://ruby.fm"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new
SitemapGenerator::Sitemap.sitemaps_host = "https://#{ENV['S3_BUCKET']}.s3.amazonaws.com/"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  # Static pages
  add '/about', :changefreq => 'weekly'
  add '/terms', :changefreq => 'weekly'

  # Index all channels
  Channel.find_each do |channel|
    add slugged_channel_path(channel.slug), :lastmod => channel.updated_at
  end

  # Index all episodes
  Episode.find_each do |episode|
    add slugged_channel_episode_path(episode.channel.slug, episode.slug), :lastmod => episode.updated_at
  end
end


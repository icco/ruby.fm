class SitemapController < ApplicationController
  include ReverseProxy::Controller

  def index
    reverse_proxy "https://rubyfm-blobs.s3.amazonaws.com/sitemaps/sitemap.xml.gz"
  end
end

# Needs to be specc'd against https://www.apple.com/itunes/podcasts/specs.html
xml.instruct!
xml.rss 'xmlns:itunes' => 'http://www.itunes.com/dtds/podcast-1.0.dtd', version: '2.0' do
  xml.channel do
    xml.title @channel.title
    xml.link channel_url(@channel)
    # Validate language codes http://www.loc.gov/standards/iso639-2/php/code_list.php
    xml.language 'en-us'
    # Need to do valid XML character matching http://www.xml.com/axml/target.html#sec-references
    xml.copyright "&#xA9; #{Time.now.year} #{@channel.author}"
    xml.itunes :author, @channel.author
    # should be a boolean
    xml.itunes :explicit, 'yes'
    # Single category https://www.apple.com/itunes/podcasts/specs.html#category
    xml.itunes :category, :text => 'Music'
    # Subcategories
    # xml.itunes :category, :text => 'Government &amp; Organizations TEST' do
      # xml.itunes :category, :text => 'Local TEST'
    # end
    xml.itunes :owner do
      xml.itunes :name, @channel.author
      xml.itunes :email, @channel.user.email
    end
    xml.itunes :image, :href => 'https://ruby.fm/brunch-club.jpg'

    @podcasts.each do |podcast|
      xml.item do
        xml.title podcast.title
        xml.itunes :author, @channel.author
        # xml.itunes :subtitle, 'Hello'
        unless podcast.notes.blank?
          xml.itunes :summary do
            # Needs to be able to escape <a>s
            xml.cdata! truncate(podcast.notes, length: 4000)
          end
        end
        # JPEG or PNG, RGB color space, minimum size of 1400 x 1400 pixels and
        # a maximum size of 2048 x 2048 pixels
        # https://www.apple.com/itunes/podcasts/specs.html#image
        xml.itunes :image, :href => 'https://ruby.fm/brunch-club.jpg'
        # Valid formats are M4A, MP3, MOV, MP4, M4V, PDF, and EPUB
        xml.enclosure url: podcast.audio, length: podcast.audio.size, type: 'audio/mpeg'
        xml.guid(podcast.id)
        xml.pubDate podcast.created_at.rfc2822
        xml.itunes :duration, Time.at(podcast.length).utc.strftime("%H:%M:%S")
      end
    end
  end
end

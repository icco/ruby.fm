# Needs to be specc'd against https://www.apple.com/itunes/podcasts/specs.html
xml.instruct!
xml.rss 'xmlns:itunes' => 'http://www.itunes.com/dtds/track-1.0.dtd', version: '2.0' do
  xml.show do
    xml.title @show.name
    xml.link show_url(@show)
    # Validate language codes http://www.loc.gov/standards/iso639-2/php/code_list.php
    xml.language 'en-us'
    # Need to do valid XML character matching http://www.xml.com/axml/target.html#sec-references
    #xml.copyright "&#xA9; #{Time.now.year} #{@show.author}"
    #xml.itunes :author, @show.author
    # should be a boolean
    xml.itunes :explicit, 'yes'
    # Single category https://www.apple.com/itunes/podcasts/specs.html#category
    xml.itunes :category, :text => 'Music'
    # Subcategories
    # xml.itunes :category, :text => 'Government &amp; Organizations TEST' do
      # xml.itunes :category, :text => 'Local TEST'
    # end
    #xml.itunes :owner do
    #  xml.itunes :name, @show.author
    #  xml.itunes :email, @show.user.email
    #end
    xml.itunes :image, :href => 'https://ruby.fm/brunch-club.jpg'

    @show.tracks.each do |track|
      xml.item do
        xml.title track.title
        xml.itunes :author, track.author
        # xml.itunes :subtitle, 'Hello'
        unless track.notes.blank?
          xml.itunes :summary do
            # Needs to be able to escape <a>s
            xml.cdata! truncate(track.notes, length: 4000)
          end
        end
        # JPEG or PNG, RGB color space, minimum size of 1400 x 1400 pixels and
        # a maximum size of 2048 x 2048 pixels
        # https://www.apple.com/itunes/podcasts/specs.html#image
        xml.itunes :image, :href => 'https://ruby.fm/brunch-club.jpg'
        # Valid formats are M4A, MP3, MOV, MP4, M4V, PDF, and EPUB
        xml.enclosure url: track.audio, length: track.audio.size, type: 'audio/mpeg'
        xml.guid(track.id)
        xml.pubDate track.created_at.rfc2822
        xml.itunes :duration, Time.at(track.length).utc.strftime("%H:%M:%S")
      end
    end
  end
end

# Needs to be specc'd against https://www.apple.com/itunes/podcasts/specs.html
xml.instruct!
xml.rss 'version' => '2.0', 'xmlns:itunes' => 'http://www.itunes.com/dtds/podcast-1.0.dtd', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    cache @channel do
      # <atom:link href="http://dallas.example.com/rss.xml" rel="self" type="application/rss+xml" />
      xml.tag! 'atom:link', :rel => 'self', :type => 'application/rss+xml', :href => slugged_channel_url(@channel.id, format: :xml)
      xml.title do
        xml.cdata!(@channel.title)
      end

      if @channel.website_url.blank?
        xml.link(channel_url(@channel.slug))
      else
        xml.link(@channel.website_url)
      end

      # Validate language codes http://www.loc.gov/standards/iso639-2/php/code_list.php
      xml.language('en-us')

      # Need to do valid XML character matching http://www.xml.com/axml/target.html#sec-references
      xml.copyright("© #{Time.now.year} #{utf8_clean(@channel.author)}")
      xml.itunes(:author, @channel.author)
      xml.itunes(:explicit, (@channel.episodes.any? { |p| p.explicit }) ? 'yes' : 'no')

      # Spec says we gotta have both summary and description. Weeeeee.
      xml.itunes(:summary) do
        if @channel.summary.blank?
          xml.cdata!("#{@channel.title} by #{@channel.author} with #{pluralize(@channel.episodes.count, 'episode')}")
        else
          xml.cdata!(utf8_clean(profane(@channel.summary)))
        end
      end

      xml.description do
        if @channel.summary.blank?
          xml.cdata!("#{@channel.title} by #{@channel.author} with #{pluralize(@channel.episodes.count, 'episode')}")
        else
          xml.cdata!(utf8_clean(profane(@channel.summary)))
        end
      end

      xml.itunes(:owner) do
        xml.itunes(:name, utf8_clean(@channel.author))
        xml.itunes(:email, @channel.user.email)
      end

      if @channel.image?
        url = Imgix.client.path(@channel.image.current_path).q(80).fm('jpg').fit('crop').width(2048).height(2048).to_url
        url << '.jpg'
        xml.itunes(:image, href: url.gsub(/\Ahttps/, 'http'))
      end

      @channel.single_categories.each do |category|
        xml.itunes(:category, text: h(category.name))
      end
      @channel.nested_categories.each do |parent, categories|
        xml.itunes(:category, text: h(parent)) do
          categories.each do |category|
            xml.itunes(:category, text: h(category))
          end
        end
      end

      @episodes.each do |podcast|
        if podcast.visible?
          cache podcast do
            xml.item do
              xml.title do
                xml.cdata!(Nokogiri::HTML.parse(utf8_clean(profane(podcast.title))).text.to_s)
              end
              unless podcast.notes.blank?
                notes = utf8_clean(podcast.notes)
                xml.itunes(:summary) do
                  xml.cdata!(Nokogiri::HTML.parse(truncate(strip_tags(profane(markdown(notes))), length: 4000)).text.to_s)
                end
                xml.description do
                  # Needs to be able to escape <a>s
                  xml.cdata!(Nokogiri::HTML.parse(truncate(strip_tags(profane(markdown(notes))), length: 4000)).text.to_s)
                end
              end

              # JPEG or PNG, RGB color space, minimum size of 1400 x 1400 pixels and
              # a maximum size of 2048 x 2048 pixels
              # https://www.apple.com/itunes/podcasts/specs.html#image
              if podcast.image?
                url = Imgix.client.path(podcast.image.current_path).q(80).fm('jpg').fit('crop').width(2048).height(2048).to_url
                url << '.jpg'
                xml.itunes(:image, href: url.gsub(/\Ahttps/, 'http'))
              end

              xml.itunes(:explicit, podcast.explicit ? 'yes' : 'no')

              # Valid formats are M4A, MP3, MOV, MP4, M4V, PDF, and EPUB
              xml.enclosure(url: podcast.http_audio_url, length: podcast.audio.size, type: "audio/mpeg")
              xml.guid(podcast.http_audio_url)

              if podcast.aired_at
                xml.pubDate(podcast.aired_at.rfc2822)
              else
                xml.pubDate(podcast.created_at.rfc2822)
              end

              xml.itunes(:duration, Time.at(podcast.length).utc.strftime("%H:%M:%S"))
            end
          end
        end
      end
    end
  end
end

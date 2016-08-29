class Episode < ActiveRecord::Base
  extend FriendlyId

  IMAGE_MIN_SIZE = 400

  belongs_to(:channel, touch: true)

  friendly_id(:slug_candidates, use: :scoped, scope: :channel)

  validates(:title,      presence: true)
  validates(:channel_id, presence: true)
  validates(:slug,       presence: true, uniqueness: { scope: [:channel_id, :slug] })
  validates(:length, numericality: { only_integer: true })

  validate :validate_minimum_dimensions

  scope(:visible, -> { where(visible: true) })
  scope(:not_visible, -> { where(visible: false) })

  scope(:recent, -> { order(created_at: :desc) })

  mount_uploader(:audio, AudioUploader)
  mount_uploader(:image, ImageUploader)

  def resized_image_url!
    Imgix.client
         .path(image.s3_path)
         .q(70)
         .h(48)
         .w(48)
         .dpr(2)
         .fit('crop')
         .mask('ellipse')
         .to_url
  end

  def resized_image_url
    Rails.cache.fetch("episode-#{episode.id}-resized_image_url-#{episode.updated_at.to_i}") do
      resized_image_url!
    end
  end

  # TODO: Check audio file to make sure the correct extension is there

  def http_audio_url
    https_audio_url.gsub(/\Ahttps/, 'http')
  end

  def https_audio_url
    self.audio.to_s
  end

  def image_url
    url = super
    if url
      url.sub('rubyfm-blobs.s3.amazonaws.com', 'rubyfm.imgix.net')
    elsif self.channel.image_url
      self.channel.image_url.sub('rubyfm-blobs.s3.amazonaws.com', 'rubyfm.imgix.net')
    else
      nil
    end
  end

  def update_play_count
    self.play_count = keen_plays
    save
  end

  def validate_minimum_dimensions
    return true unless image_changed? && image.try(:file)

    path = image.file.path
    image = MiniMagick::Image.open(path)

    if image.width < IMAGE_MIN_SIZE || image.height < IMAGE_MIN_SIZE
      errors.add(:image, "minimum size is #{IMAGE_MIN_SIZE}x#{IMAGE_MIN_SIZE}")
    end

    # Cleanup after ourselves to ensure we don't have file descriptors held
    # open. See {MiniMagic::Image#destroy!} documentation for more info.
    image.destroy!
  end

  def visible?
    self.visible == true
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

  def slug_candidates
    [
      :title,
      [:title, :fallback_count]
    ]
  end

  def slug_default
    SecureRandom.uuid
  end

  def fallback_count
    if channel.nil?
      1
    else
      channel.episodes.count + 1
    end
  end

  private

  def keen_plays
    Keen.count("podcast.download", {
      filters: [
        {
          property_name: "episode_id",
          operator: "eq",
          property_value: self.id
        }
      ],
      timeframe: {
        start: self.created_at.iso8601
      }
    })
  end
end

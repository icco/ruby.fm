class Episode < ActiveRecord::Base
  extend FriendlyId

  IMAGE_MIN_SIZE = 400

  belongs_to(:channel)

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

  friendly_id(:slug_candidates, use: :scoped, scope: :channel)

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

  def slug_candidates
    [
      :title,
      [:title, :fallback_count]
    ]
  end

  def fallback_count
    if channel.nil?
      1
    else
      channel.episodes.count + 1
    end
  end
end

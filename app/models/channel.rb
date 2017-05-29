class Channel < ApplicationRecord
  extend FriendlyId

  IMAGE_MIN_SIZE = 400

  has_many(:episodes)
  belongs_to(:user)

  validates(:title,   presence: true, length: { maximum: 255 })
  validates(:user_id, presence: true)
  validates(:slug,    presence: true, uniqueness: true, length: { maximum: 64 })
  validates(:website_url, url: { allow_blank: true, no_local: true })

  validates(:summary, length: { maximum: 4000 })
  validate :validate_minimum_dimensions

  friendly_id(:slug_candidates, use: :slugged)

  scope :published, -> { where(published: true) }
  scope :not_published, -> { where(published: false) }

  mount_uploader(:image, ImageUploader)

  before_validation :scrub_categories

  def episodes_visible_present?
    episodes.visible.count > 1
  end

  def total_plays
    episodes.sum(:play_count)
  end

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
    Rails.cache.fetch("channel-#{self.id}-resized_image_url-#{self.updated_at.to_i}") do
      resized_image_url!
    end
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

  def category_list
    categories.map { |v| Category.find(v) }
  end

  def nested_categories
    hash = {}
    category_list.select { |c| c.nested? }.each do |category|
      hash[category.parent.name] ||= []
      hash[category.parent.name] << category.name
    end
    hash
  end

  def single_categories
    category_list.select { |c| c.single? }
  end

  def categories=(value)
    super(Array(value))
  end

  def scrub_categories
    children = Category.children.map(&:name)
    self.categories = self.categories.reject { |v| !children.include?(v) }.uniq
  end

  def slug_candidates
    [
      :title,
      [:title, :fallback_count]
    ]
  end

  def fallback_count
    user.channels.count + 1
  end
end

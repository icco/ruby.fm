class Podcast < ActiveRecord::Base
  before_validation :slugify, on: [:create]

  validates :channel_id, presence: true
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: { scope: [:channel_id, :slug] }
  validates :length, numericality: { only_integer: true }

  scope :published, -> { where(published: true) }
  scope :not_published, -> { where(published: false) }

  belongs_to :channel
  mount_uploader :audio, AudioUploader

  def published?
    self.published == true
  end

  def slugify
    unless self.title.blank?
      if Podcast.exists?(channel_id: self.channel_id, slug: self.title.parameterize)
        self.slug = "%s-%s" % [self.title.parameterize, SecureRandom.hex(3)]
      else
        self.slug = self.title.parameterize
      end
    end
    self.slug
  end
end

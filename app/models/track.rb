class Track < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  # Adds CarrierWave
  mount_uploader :audio, AudioUploader

  # Makes sure track length is an int
  validates :length, numericality: { only_integer: true }

  # Adds helper methods for filtering
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  alias_attribute :published?, :published

  # Slugs (urls)
  validates :slug, presence: true, uniqueness: true
  before_validation :slugify, on: [:create]

  # Takes the title of the track and turns it into a slug to be used in urls.
  def slugify
    unless self.title.blank?
      prmrizd = self.title.parameterize
      if self.exists?(slug: prmrizd)
        self.slug = "#{prmrizd}-#{SecureRandom.hex(4)}"
      else
        self.slug = prmrizd
      end
    end

    return self.slug
  end
end

class Show < ActiveRecord::Base
  has_many :tracks

  # Slugs (urls)
  validates :slug, presence: true, uniqueness: true
  before_validation :slugify, on: [:create]

  # Takes the name of the show and turns it into a slug to be used in urls.
  def slugify
    unless self.name.blank?
      prmrizd = self.name.parameterize
      if self.class.exists?(slug: prmrizd)
        self.slug = "#{prmrizd}-#{SecureRandom.hex(4)}"
      else
        self.slug = prmrizd
      end
    end

    return self.slug
  end
end

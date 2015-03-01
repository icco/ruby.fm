class Channel < ActiveRecord::Base
  before_validation :slugify, on: [:create]

  validates :user_id, presence: true
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :visible, -> { where(visible: true) }
  scope :not_visible, -> { where(visible: false) }

  has_many :podcasts, dependent: :destroy
  belongs_to :user

  def published?
    self.visible == true
  end

  def slugify
    unless self.title.blank?
      if Channel.exists?(slug: self.title.parameterize)
        self.slug = "%s-%s" % [self.title.parameterize, SecureRandom.hex(3)]
      else
        self.slug = self.title.parameterize
      end
    end
    self.slug
  end
end

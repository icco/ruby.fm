class Channel < ActiveRecord::Base
  extend FriendlyId

  has_many(:episodes)
  belongs_to(:user)

  validates(:title,   presence: true)
  validates(:user_id, presence: true)
  validates(:slug,    presence: true, uniqueness: true)
  validates(:website_url, url: { allow_blank: true, no_local: true })

  friendly_id(:slug_candidates, use: :slugged)

  scope :published, -> { where(published: true) }
  scope :not_published, -> { where(published: false) }

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

class Episode < ActiveRecord::Base
  extend FriendlyId

  belongs_to(:channel)

  validates(:title,      presence: true)
  validates(:channel_id, presence: true)
  validates(:slug,       presence: true, uniqueness: { scope: [:channel_id, :slug] })
  validates(:length, numericality: { only_integer: true })

  scope(:visible, -> { where(visible: true) })
  scope(:not_visible, -> { where(visible: false) })

  scope(:recent, -> { order(:created_at) })

  mount_uploader(:audio, AudioUploader)
  mount_uploader(:image, ImageUploader)

  friendly_id(:slug_candidates, use: :scoped, scope: :channel)

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

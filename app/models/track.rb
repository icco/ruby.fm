class Track < ActiveRecord::Base
  belongs_to :show

  # Adds CarrierWave
  mount_uploader :audio, AudioUploader

  # Makes sure track length is an int
  validates :length, numericality: { only_integer: true }

  # Adds helper methods for filtering
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  alias_attribute :published?, :published
end

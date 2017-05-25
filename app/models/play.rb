class Play < ApplicationRecord
  belongs_to :episode

  validates :episode_id, presence: true
  validates :total, presence: true
  validates :bucket, presence: true

  def increment
    self.total += 1
    self.save
  end
end

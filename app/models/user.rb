class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable

  has_many :channels
  has_many :episodes, through: :channels

  validates :email, presence: true

  # TODO: This is only temporary until we figure out some sort of billing
  #       structure
  def paying?
    true
  end
end

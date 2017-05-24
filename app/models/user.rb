class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable

  has_many :channels
  has_many :episodes, through: :channels

  # TODO: This is only temporary until we figure out some sort of billing
  #       structure
  def paying?
    true
  end

  def current_admin
    current_user && current_user.is_admin
  end
end

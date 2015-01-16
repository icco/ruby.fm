class Track < ActiveRecord::Base
  belongs_to :show
  has_one :blob
end

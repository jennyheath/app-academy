class Track < ActiveRecord::Base
  validates :album_id, :title, :track_type, :lyrics, presence: true
  validates :track_type, inclusion: { in: ["REGULAR", "BONUS"] }

  belongs_to :album
  has_one(
    :band,
    through: :album,
    source: :band
  )
end

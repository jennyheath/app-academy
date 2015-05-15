class Album < ActiveRecord::Base
  validates :band_id, :title, :recording_type, presence: true
  validates :recording_type, inclusion: { in: ["LIVE", "STUDIO"] }

  belongs_to :band
  has_many :tracks, dependent: :destroy
end

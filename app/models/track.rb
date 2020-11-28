class Track < ApplicationRecord
  validates :title, presence: true
  validates :artist, presence: true

  def self.create_from_scraping(tracks)
    tracks.each do |track_hash|
      Track.create!(track_hash)
    end
  end
end

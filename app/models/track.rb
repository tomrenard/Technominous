class Track < ApplicationRecord
  validates :title, presence: true
  validates :artist, presence: true

  def self.create_from_scraping(tracks)
    tracks.each do |track_info|
      Track.create!(track_info)
    end
  end
end

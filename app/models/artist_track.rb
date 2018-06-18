class ArtistTrack < ActiveRecord::Base
    belongs_to :artist
    belongs_to :track
end
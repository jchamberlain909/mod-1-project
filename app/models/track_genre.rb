class TrackGenre < ActiveRecord::Base
    belongs_to :track
    belongs_to :genre
end
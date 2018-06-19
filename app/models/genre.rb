class Genre < ActiveRecord::Base
    has_many :track_genres
    has_many :tracks, through: :track_genres
end
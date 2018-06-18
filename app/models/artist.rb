class Artist < ActiveRecord::Base
    has_many :artist_albums
    has_many :albums, through: :artist_albums
    has_many :artist_tracks
    has_many :tracks, through: :artist_tracks
end
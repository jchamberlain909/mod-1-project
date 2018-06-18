class Track < ActiveRecord::Base
    has_many :playlist_tracks
    has_many :playlists, through: :playlist_tracks
    belongs_to :album
    has_many :artist_tracks
    has_many :artists, through: :artist_tracks
    
end
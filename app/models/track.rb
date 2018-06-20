class Track < ActiveRecord::Base
    has_many :playlist_tracks
    has_many :playlists, through: :playlist_tracks
    belongs_to :album
    has_many :artist_tracks
    has_many :artists, through: :artist_tracks
    def self.create_track (track, playlist)
        new_track = Track.find_or_create_by(name: track.name, popularity: track.popularity)
        #Add to playlist
        playlist.tracks << new_track unless playlist.tracks.include? (new_track)
        new_track
    end
end
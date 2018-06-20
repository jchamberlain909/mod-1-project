class Track < ActiveRecord::Base
    has_many :playlist_tracks
    has_many :playlists, through: :playlist_tracks
    belongs_to :album
    has_many :artist_tracks
    has_many :artists, through: :artist_tracks
    def self.create_track (track, playlist)
        audio_features = track.audio_features
        new_track = Track.find_or_create_by(name: track.name, popularity: track.popularity, duration_ms: track.duration_ms, danceability: audio_features.danceability, valence: audio_features.valence, energy: audio_features.energy, tempo: audio_features.tempo)
        #Add to playlist
        playlist.tracks << new_track unless playlist.tracks.include? (new_track)
        new_track
    end
end
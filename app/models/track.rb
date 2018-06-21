class Track < ActiveRecord::Base
    has_many :playlist_tracks
    has_many :playlists, through: :playlist_tracks
    belongs_to :album
    has_many :artist_tracks
    has_many :artists, through: :artist_tracks
    def self.create_track (track, playlist)
        new_track = Track.find_or_create_by(name: track.name, popularity: track.popularity, spotify_track_id:track.id)
        #Add to playlist
        playlist.tracks << new_track unless playlist.tracks.include? (new_track)
        new_track
    end

    def get_audio_features
        audio_features = RSpotify::Track.find(self.spotify_track_id).audio_features
        self.danceability = audio_features.danceability
        self.duration_ms = audio_features.duration_ms
        self.energy = audio_features.energy
        self.tempo = audio_features.tempo
        self.valence = audio_features.valence
        self.save
    end 
end
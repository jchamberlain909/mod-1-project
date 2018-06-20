class Album < ActiveRecord::Base
    has_many :tracks
    has_many :artist_albums
    has_many :artists, through: :artist_albums

    def self.create_album (track, new_track)
        #Create Album
        spotify_album_object = track.album
        new_album = Album.find_or_create_by(name: spotify_album_object.name)
        new_album.tracks << new_track unless new_album.tracks.include? new_track 
        new_album
    end
    
end
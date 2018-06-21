class Artist < ActiveRecord::Base
    has_many :artist_albums
    has_many :albums, through: :artist_albums
    has_many :artist_tracks
    has_many :tracks, through: :artist_tracks
    has_many :artist_genre
    has_many :genres, through: :artist_genre


    def self.create_artists (track, new_track, new_album)
        #Create Artist
        spotify_artist_array = track.artists
        spotify_artist_array.map do |artist|
            new_artist = Artist.find_or_create_by(name:artist.name, spotify_artist_id: artist.id, web_url:artist.external_urls["spotify"])
            new_artist.tracks << new_track unless new_artist.tracks.include?(new_track) 
            new_artist.albums << new_album unless new_artist.albums.include?(new_album) 
            self.add_genre(new_artist, artist.genres)
        end
    end

    def self.add_genre (artist, genre_array)
        genre_array.each do |genre|
            new_genre = Genre.find_or_create_by(name: genre)
            artist.genres << new_genre unless artist.genres.include? (new_genre)
        end 
    end 
end
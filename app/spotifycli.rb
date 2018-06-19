class SpotifyCLI
    attr_accessor :user_id, :user
    def call
        get_user
    end 

    def get_user
        puts "Please enter a spotify user ID:"
        self.user_id = gets.chomp
        self.populate_user_data
    end

    def populate_user_data
        spotify_user_object = RSpotify::User.find(self.user_id)
        self.user = User.find_or_create_by(spotify_user_id: self.user_id, display_name: spotify_user_object.display_name)
        self.populate_playlist_data (spotify_user_object)
    end

    def populate_playlist_data (spotify_user_object)
        playlist_arr = spotify_user_object.playlists
        playlist_objects = playlist_arr.map do |playlist| 
            new_playlist = Playlist.find_or_create_by(name: playlist.name)
            self.user.playlists << new_playlist unless self.user.playlists.include? new_playlist
            new_playlist
        end 
        self.populate_track_data(playlist_arr, playlist_objects)
    end

    def populate_track_data playlist_arr, playlist_objects   
        playlist_arr.each_with_index do |playlist, index|
            playlist.tracks.each do |track|
                new_track = Track.find_or_create_by(name: track.name, popularity: track.popularity)
                #Add to playlist
                playlist_objects[index].tracks << new_track unless playlist_objects[index].tracks.include? (new_track)
                #Create Album
                spotify_album_object = track.album
                new_album = Album.find_or_create_by(name: spotify_album_object.name)
                new_album.tracks << new_track unless new_album.tracks.include? new_track
                #Create Artist
                spotify_artist_array = track.artists
                spotify_artist_array.each do |artist|
                    new_artist = Artist.find_or_create_by(name:artist.name)
                    new_artist.tracks << new_track unless new_artist.tracks.include? (new_track) 
                    new_artist.albums << new_album unless new_artist.albums.include? (new_album) 
                end 
                
            end
        end 
    end
    
end
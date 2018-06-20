class SpotifyCLI
    attr_accessor :user
    def call
        get_user
        user_options
    end 

    def user_options
        puts "1. List Playlists"
        puts "2. User Snapshot"
        puts "3. Filter My Tracks By Genre"
        puts "What would you like to do?"
        user_input = gets.chomp  
        case(user_input)
        when '1'
            self.user.show_playlists
        when '2'
            self.user.create_snapshot
        when '3'
            self.user.filter_by_genre
        end      
    end

    def get_user
        puts "Please enter your spotify display name:"
        user_display_name = gets.chomp

        if(User.find_by(display_name: user_display_name) != nil)
            self.user = User.find_by(display_name:user_display_name)
            puts "Welcome back #{user_display_name}"
        else
            puts "Hello, new user. Please enter your spotify id to be added"
            user_id = gets.chomp
            self.populate_new_user_data (user_id)
        end
        
    end

    def populate_new_user_data user_id
        spotify_user_object = RSpotify::User.find(user_id)
        self.user = User.create(spotify_user_id: user_id, display_name: spotify_user_object.display_name)
        puts "Welcome, #{spotify_user_object.display_name}"
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
                new_track = create_track(track, playlist_objects[index])
                new_album = create_album(track, new_track)
                new_artists = create_artists(track, new_track, new_album)
                end    
            end
        end 
    end

    def create_track (track, playlist)
        new_track = Track.find_or_create_by(name: track.name, popularity: track.popularity)
        #Add to playlist
        playlist.tracks << new_track unless playlist.tracks.include? (new_track)
        new_track
    end

    def add_genre (artist, genre_array)
        genre_array.each do |genre|
            new_genre = Genre.find_or_create_by(name: genre)
            artist.genres << new_genre unless artist.genres.include? (new_genre)
        end 
    end 

    def create_album (track, new_track)
        #Create Album
        spotify_album_object = track.album
        new_album = Album.find_or_create_by(name: spotify_album_object.name)
        new_album.tracks << new_track unless new_album.tracks.include? new_track 
        new_album
    end

    def create_artists (track, new_track, new_album)
        #Create Artist
        spotify_artist_array = track.artists
        spotify_artist_array.map do |artist|
            new_artist = Artist.find_or_create_by(name:artist.name)
            new_artist.tracks << new_track unless new_artist.tracks.include?(new_track) 
            new_artist.albums << new_album unless new_artist.albums.include?(new_album) 
            add_genre(new_artist, artist.genres)
    end
    
end
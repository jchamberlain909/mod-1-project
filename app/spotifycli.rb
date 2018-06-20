class SpotifyCLI
    attr_accessor :user
    def call
        get_user
        user_options
    end 

    def user_options
        puts "1. View Playlists"
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
                new_track = Track.create_track(track, playlist_objects[index])
                #binding.pry
                new_album = Album.create_album(track, new_track)
                new_artists = Artist.create_artists(track, new_track, new_album)
                
            end
        end 
    end

    

   
    
end
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
        puts "4. Exit"
        puts "What would you like to do?"
        user_input = gets.chomp  
        case(user_input)
        when '1'
            playlist_list_options
        when '2'
            self.user.create_snapshot
        when '3'
            self.user.filter_by_genre
        when '4'
            puts "Goodbye"
        end      
    end

    def playlist_list_options
        self.user.show_playlists
        puts "Select a playlist by number or type 'back' to return"
        user_selection = gets.chomp
        if user_selection.downcase == 'back'
            user_options
        else
            playlist_num = user_selection.to_i
            playlist = self.user.playlists[playlist_num-1]
            playlist_options (playlist)
        end
    end

    def playlist_options (playlist)
        puts "1. View Tracks"
        puts "2. Playlist Snapshot"
        puts "3. Go Back"
        user_input = gets.chomp 
        case(user_input)
        when '1'
            playlist.list_tracks
        when '2'
            
        when '3'
            playlist_list_options
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
            spotify_user_object = RSpotify::User.find(user_id)
            self.user = User.create(spotify_user_id: user_id, display_name: spotify_user_object.display_name)
            puts "Welcome, #{spotify_user_object.display_name}"
            self.user.populate_user_data (spotify_user_object)
        end
        
    end
end



    
class SpotifyCLI
    attr_accessor :user
    def call
        get_user
        user_options
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
            puts "Downloading Playlist Data..."
            self.user.populate_user_data (spotify_user_object)
        end
    end

    def user_options
        puts "1. View Playlists"
        puts "2. User Snapshot"
        puts "3. Filter My Tracks By Genre"
        puts "4. Update User Data"
        puts "exit"
        puts "What would you like to do?"
        print "-> "
        user_input = gets.chomp.downcase
        system "clear"
        case(user_input)
        when '1'
            playlist_list_options
        when '2'
            self.user.create_snapshot
            user_options
        when '3'
            self.user.filter_by_genre
            user_options
        when '4'
            spotify_user_object = RSpotify::User.find(self.user.spotify_user_id.to_s)
            self.user.populate_user_data (spotify_user_object)
            user_options
        when 'exit'
            puts "Goodbye"
        end      
    end

    def playlist_list_options
        puts "#{self.user.display_name}'s Playlists"
        self.user.show_playlists
        puts "Select a playlist by number or type 'back' to return"
        print "-> "
        user_selection = gets.chomp.downcase
        system "clear"
        if user_selection.downcase == 'back'
            user_options
        else
            playlist_num = user_selection.to_i
            playlist = self.user.playlists[playlist_num-1]
            playlist_options (playlist)
        end
    end

    def playlist_options (playlist)
        puts "#{playlist.name} Selected"
        playlist.get_track_audio_features
        puts playlist.format_time(playlist.duration)
        puts "1. View Tracks"
        puts "2. Playlist Snapshot"
        puts "3. Open Playlist in web browser (mac only)"
        puts "back"
        puts "exit"
        print "-> "
        user_input = gets.chomp.downcase
        system "clear"
        case(user_input)
        when '1'
            track_list_options(playlist)
        when '2'
            playlist.snapshot
            playlist_options(playlist)
        when '3'
            system("open", playlist.web_url)
            playlist_options(playlist)
        when 'back'
            playlist_list_options
        when 'exit'
            puts "Goodbye"
        end
    end

    

    def track_list_options(playlist)
        puts "#{playlist.name} Track List"
        playlist.list_tracks
        puts "Select track by number or type 'back' to return:"
        user_input = gets.chomp.downcase
        system "clear"
        case (user_input)
        when 'back'
            playlist_options (playlist)
        when 'exit'
            puts "Goodbye"
        else
            track = playlist.tracks[user_input.to_i - 1]
            track_options(track, playlist)
        end 
    end

    def track_options(track, playlist)
        puts "#{track.name} selected"
        puts "1. Open track in web browser (mac only)"
        puts "2. Track Audio Details"
        puts "back"
        puts "exit"
        print "-> "
        user_input = gets.chomp.downcase
        system "clear"
        case (user_input)
        when '1'
            system("open", track.web_url)
            track_options(track, playlist)
        when '2'
            track.print_audio_features
            track_options(track, playlist)
        when 'back'
            track_list_options(playlist)
        when 'exit'
            puts "Goodbye"
        end 

    end
end



    
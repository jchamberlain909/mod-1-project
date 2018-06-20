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
            spotify_user_object = RSpotify::User.find(user_id)
            self.user = User.create(spotify_user_id: user_id, display_name: spotify_user_object.display_name)
            puts "Welcome, #{spotify_user_object.display_name}"
            self.user.populate_user_data (spotify_user_object)
        end
        
    end
end



    
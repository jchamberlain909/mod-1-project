class User < ActiveRecord::Base
    has_many :playlists
    attr_accessor :tracks


    def populate_user_data (spotify_user_object)
        self.populate_playlist_data (spotify_user_object)
    end

    def populate_playlist_data (spotify_user_object)
        playlist_arr = spotify_user_object.playlists
        playlist_objects = playlist_arr.map do |playlist| 
            new_playlist = Playlist.find_or_create_by(name: playlist.name, spotify_playlist_id: playlist.id, web_url:playlist.external_urls["spotify"])
            self.playlists << new_playlist unless self.playlists.include? new_playlist
            new_playlist
        end 
        self.populate_track_data(playlist_arr, playlist_objects)
    end

    def populate_track_data playlist_arr, playlist_objects   
        playlist_arr.each_with_index do |playlist, index|
            puts "Downloading #{playlist.name}"
            sleep(1.0)
            playlist.tracks.each do |track|
                new_track = Track.create_track(track, playlist_objects[index])
                if(Track.find(new_track.id)== nil)
                    new_album = Album.create_album(track, new_track)
                    new_artists = Artist.create_artists(track, new_track, new_album)
                end
                sleep(0.1)
            end
        end 
    end

    def show_playlists
        self.playlists.each_with_index {|playlist, index| puts "#{index+1}. #{playlist.name}" }
    end

    def create_snapshot
        spotify_user_object = RSpotify::User.find("#{self.spotify_user_id}")
        puts "Snapshot"
        puts "Top 5 Genres"
        puts top_5_genres
        puts "Top 3 Artists"
        puts top_3_artists
        puts "Follower Count"
        puts get_follower_count(spotify_user_object)
    end 

    def get_follower_count spotify_user_object
        spotify_user_object.followers["total"]
    end

    def get_genre_list
        genres = []
        self.tracks = get_all_tracks if self.tracks == nil
        self.tracks.each do |track|
            track.artists.each do |artist|
                artist.genres.each do |genre|
                    genres << genre
                end
            end 
        end 
        genres
    end 

    def top_5_genres      
        genres = get_genre_list

        genre_frequency = {}
        genres.each do |genre|
            if genre_frequency[genre] == nil
                genre_frequency[genre]=1
            else
                genre_frequency[genre]+=1
            end
        end 

        sorted_genres = genre_frequency.sort_by {|genre, freq| freq}.reverse
        
        sorted_genres[0..4].map {|genre_freq| genre_freq[0].name}
    end

    def get_artist_list
        artists = []
        self.tracks = get_all_tracks if self.tracks == nil
        self.tracks.each do |track|
            track.artists.each {|artist| artists << artist}
        end 
        artists
    end

    def top_3_artists
        artists = get_artist_list
        artist_frequency = {}
        artists.each do |artist|
            if artist_frequency[artist] == nil
                artist_frequency[artist] = 1
            else
                artist_frequency[artist]+=1
            end 
        end

        sorted_artists = artist_frequency.sort_by{|artist,freq| freq}.reverse

        sorted_artists[0..2].map {|artist_freq| artist_freq[0].name}

    end

    def get_all_tracks
        tracks_arr = []
        self.playlists.each do |playlist|
            playlist.tracks.each do |track|
                tracks_arr << track
            end
        end
        tracks_arr
    end


    def filter_by_genre
        self.tracks = get_all_tracks if self.tracks == nil
        user_genre_selection = nil
        while (user_genre_selection.nil?)
            user_genre_selection = get_user_genre_selection
        end 
        filtered_tracks = []
        self.tracks.each do |track|
            track.artists.each do |artist|
                filtered_tracks << track if artist.genres.map{|g|g.name}.include?(user_genre_selection)
            end
        end

        puts filtered_tracks.uniq.map {|s| s.name}
        
    end
    
    def get_user_genre_selection
        puts "Enter a genre to filter tracks by:"
        user_genre_selection = gets.chomp.downcase
        if RSpotify::Recommendations.available_genre_seeds.include?(user_genre_selection)
            user_genre_selection
        else
            puts "Invalid Genre"
            nil
        end 
    end
end
class Playlist < ActiveRecord::Base
    belongs_to :user
    has_many :playlist_tracks
    has_many :tracks, through: :playlist_tracks
    

    def list_tracks
        self.tracks.each_with_index { |track, index| puts "#{index+1}. #{track.name}" }
    end
end
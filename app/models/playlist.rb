class Playlist < ActiveRecord::Base
    belongs_to :user
    has_many :playlist_tracks
    has_many :tracks, through: :playlist_tracks
    
    def list_tracks
        self.tracks.each_with_index { |track, index| puts "#{index+1}. #{track.name}" }
    end

    def snapshot
        puts "Average Energy: #{avg_energy}"
        puts "Average Tempo: #{avg_tempo}"
        puts "Average Valence: #{avg_valence}"
        puts "Average Danceability: #{avg_danceability}"
        puts "Duration in ms: #{duration}"  
    end

    def get_track_audio_features
        self.tracks.each {|track| track.get_audio_features}
    end

    def avg_energy
        total_energy = self.tracks.reduce(0.0) {|acc, track| acc+ track.energy}
        total_energy/self.tracks.length
    end

    def avg_tempo
        total_tempo = self.tracks.reduce(0) {|acc, track| acc+ track.tempo}
        total_tempo/self.tracks.length
    end

    def avg_valence
        total_valence = self.tracks.reduce(0.0) {|acc, track| acc+ track.valence}
        total_valence/self.tracks.length
    end

    def avg_danceability
        total_danceability = self.tracks.reduce(0.0) {|acc, track| acc+ track.danceability}
        total_danceability/self.tracks.length
    end

    def duration
        total_ms = self.tracks.reduce(0) {|acc, track| acc+ track.duration_ms}
    end
end
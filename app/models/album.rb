class Album < ActiveRecord::Base
    has_many :tracks
    has_many :artist_albums
    has_many :artists, through: :artist_albums
    
end
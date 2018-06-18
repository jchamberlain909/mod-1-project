require "sinatra/activerecord"



# Create a User
user1 = User.find_or_create_by(display_name:"jchamberlain")

#Create some Artists
weeknd = Artist.find_or_create_by(name: "The Weeknd")
lana_del_ray = Artist.find_or_create_by(name: "Lana Del Ray")
#Create some Albums
trilogy = Album.find_or_create_by(name: "Trilogy")
kissland = Album.find_or_create_by(name: "Kissland")
beauty_behind_the_madness = Album.find_or_create_by(name: "Beauty Behind The Madness")
starboy = Album.find_or_create_by(name: "Starboy")
#Create some Tracks
#Trilogy tracks
tracks =[]
high_for_this = Track.find_or_create_by(name: "High for This")
tracks << high_for_this
wicked_games = Track.find_or_create_by(name: "Wicked Games")
tracks << wicked_games
trilogy.tracks << high_for_this
trilogy.tracks << wicked_games
#Kissland tracks
adaptation = Track.find_or_create_by(name: "Adaptation")
tracks << adaptation
tears_in_the_rain = Track.find_or_create_by(name: "Tears in the Rain")
tracks << tears_in_the_rain
kissland.tracks << adaptation
kissland.tracks << tears_in_the_rain
#Beauty Behind The Madness tracks
real_life = Track.find_or_create_by(name: "Real Life")
tracks << real_life
prisoner = Track.find_or_create_by(name: "Prisoner")
tracks << prisoner
beauty_behind_the_madness.tracks << real_life
beauty_behind_the_madness.tracks << prisoner
#Starboy tracks
starboy_track = Track.find_or_create_by(name: "Starboy")
tracks << starboy_track
stargirl_interlude = Track.find_or_create_by(name: "Stargirl Interlude")
tracks << stargirl_interlude
starboy.tracks << starboy_track
starboy.tracks << stargirl_interlude

#Give tracks artists
tracks.each {|track| track.artists << weeknd}
prisoner.artists << lana_del_ray
stargirl_interlude.artists << lana_del_ray

#Create some Playlists

playlist1 = Playlist.find_or_create_by(name: "All Weeknd Long")
tracks.each {|track| playlist1.tracks << track}





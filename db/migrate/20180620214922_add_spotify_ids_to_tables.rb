class AddSpotifyIdsToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :spotify_track_id, :string
    add_column :albums, :spotify_album_id, :string
    add_column :artists, :spotify_artist_id, :string
    add_column :playlists, :spotify_playlist_id, :string
  end
end

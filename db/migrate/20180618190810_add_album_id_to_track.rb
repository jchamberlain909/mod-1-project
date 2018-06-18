class AddAlbumIdToTrack < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :album_id, :integer
  end
end

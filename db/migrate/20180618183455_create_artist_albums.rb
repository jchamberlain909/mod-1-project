class CreateArtistAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_albums do |t|
      t.integer :artist_id
      t.integer :album_id
    end 
  end
end

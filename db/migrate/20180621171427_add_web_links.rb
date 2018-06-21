class AddWebLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :web_url, :string
    add_column :albums, :web_url, :string
    add_column :artists, :web_url, :string
    add_column :playlists, :web_url, :string
  end
end

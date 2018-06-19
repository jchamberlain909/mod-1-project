class AddSpotifyUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :spotify_user_id, :integer
  end
end

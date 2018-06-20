class AddAudioFeaturesToTrack < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :duration_ms, :integer
    add_column :tracks, :danceability, :float
    add_column :tracks, :valence, :float
    add_column :tracks, :energy, :float
    add_column :tracks, :tempo, :integer
  end
end

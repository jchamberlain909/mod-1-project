class CreateTrackGenre < ActiveRecord::Migration[5.2]
  def change
    create_table :track_genres do |t|
        t.integer :track_id
        t.integer :genre_id
    end 
  end
end

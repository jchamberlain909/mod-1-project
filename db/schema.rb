# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_20_214922) do

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.string "spotify_album_id"
  end

  create_table "artist_albums", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "album_id"
  end

  create_table "artist_genres", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "genre_id"
  end

  create_table "artist_tracks", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "track_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "spotify_artist_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
  end

  create_table "playlist_tracks", force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "track_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.string "spotify_playlist_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.integer "popularity"
    t.integer "album_id"
    t.integer "duration_ms"
    t.float "danceability"
    t.float "valence"
    t.float "energy"
    t.integer "tempo"
    t.string "spotify_track_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "display_name"
    t.integer "spotify_user_id"
  end

end

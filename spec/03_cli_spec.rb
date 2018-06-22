require "spec_helper"


describe "spotifycli" do
    let(:spotifycli) {SpotifyCLI.new}

    describe "get_user" do
        it "gets the user" do
            allow(spotifycli).to receive(:gets).and_return("Jared Chamberlain", "exit")
            expect($stdout).to receive(:puts).with("Please enter your spotify display name:")
            expect($stdout).to receive(:puts).with("Welcome back Jared Chamberlain")
            expect($stdout).to receive(:puts).with("1. View Playlists")
            expect($stdout).to receive(:puts).with("2. User Snapshot")
            expect($stdout).to receive(:puts).with("3. Filter My Tracks By Genre")
            expect($stdout).to receive(:puts).with("4. Update User Data")
            expect($stdout).to receive(:puts).with("exit")
            expect($stdout).to receive(:puts).with("What would you like to do?")
            expect($stdout).to receive(:puts).with("Goodbye")


            spotifycli.call
        end
    end

    describe "track_list_options" do
        it "prints out the tracks" do 
            allow(spotifycli).to receive(:gets).and_return("exit")
            expect($stdout).to receive(:puts).with("Test Playlist Track List")
            expect($stdout).to receive(:puts).with("1. track 1")
            expect($stdout).to receive(:puts).with("2. track 2")
            expect($stdout).to receive(:puts).with("3. track 3")

            expect($stdout).to receive(:puts).with("Select track by number or type 'back' to return:")
            expect($stdout).to receive(:puts).with("Goodbye")


            playlist = Playlist.new(name: "Test Playlist")
            playlist.tracks << Track.new(name: "track 1")
            playlist.tracks << Track.new(name: "track 2")
            playlist.tracks << Track.new(name: "track 3")
            spotifycli.track_list_options(playlist)
        end 
    end 
end 
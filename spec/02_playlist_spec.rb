require 'spec_helper'

describe "Playlist" do
    let(:user) {User.new(display_name: 'Jared Chamberlain', spotify_user_id: '12128242235')}

    describe '#initialize' do 
        it "accepts name" do
            new_playlist=Playlist.new(name: "test")
            expect(new_playlist.name).to eq("test")
        end
        
        it "has an owner" do
            new_playlist=Playlist.new(name: "test", user: user)
            expect(new_playlist.user).to eq(user)
        end
    end    

end
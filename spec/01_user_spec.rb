require 'spec_helper'

describe "User" do
    let(:user) {User.new(display_name: 'Jared Chamberlain', spotify_user_id: '12128242235')}

    describe '#initialize' do 
        it "accepts display_name and spotify_user_id" do
            new_user = User.new(display_name: 'Jared Chamberlain', spotify_user_id: '12128242235')
            expect(new_user.spotify_user_id).to eq(12128242235) 
 
        end 
    end     

end
require 'faker'

describe User do
	let(:user) { FactoryGirl.create(:user) }

	it 'has a valid factory' do
		expect(user).to be_valid
	end

	it 'needs a first name' do
		expect(FactoryGirl.build(:user, first_name: nil)).to_not be_valid
	end

	it 'needs a last name' do
		expect(FactoryGirl.build(:user, last_name: nil)).to_not be_valid
	end

	it 'needs an instrument' do
		expect(FactoryGirl.build(:user, instrument: nil)).to_not be_valid
	end

	it 'can store email' do
		expect(user.email).to_not eq(nil)
	end

	it 'can store password' do
		expect(user.password).to_not eq(nil)
	end

	it 'can store state' do
		expect(user.state).to_not eq(nil)
	end

	it 'can store city' do
		expect(user.city).to_not eq(nil)
	end

	it 'can store street' do
		expect(user.street).to_not eq(nil)
	end

	it 'can give lessons' do
		expect(FactoryGirl.create(:user, :can_give_lessons).lessons).to eq(true)
	end

	it 'has genres' do
		expect(FactoryGirl.create(:user, :has_genres).genres).to eq("Rock,Classical,World")
	end

	it 'has a personal statement' do
		expect(FactoryGirl.create(:user, :has_personal_statement).statement).to eq("I love Jammer!")
	end

	it 'has uploaded songs' do
		expect(FactoryGirl.create(:user_with_a_song).songs).to_not eq(nil)
	end

	context 'class methods' do

		it '#lessons? returns whether the user is interested in giving lessons' do
			expect(FactoryGirl.create(:user, :can_give_lessons).lessons?[2]).to eq(true)
		end

		it '#neat_genres will produce a neat comma delimited list of genres' do
			expect(FactoryGirl.create(:user, :has_genres).neat_genres).to eq("Rock, Classical, World")
		end

		it '#avatar_url will return the avatar url of the current user' do
			expect(FactoryGirl.create(:user, :has_avatar).avatar_url.class).to eq(Faker::Internet.url.class)
		end

		it '#get_song_by_number will return the song specified by the number' do
			expect(FactoryGirl.create(:user_with_multiple_songs).get_song_by_number(3).song_name).to eq("Big Song 3")
		end

		it '#remove_song will delete the song at the specified number and shift all urls down' do
			urls = %w{song3_url}
			user = FactoryGirl.create(:user_with_three_songs)

			user.remove_song(2, urls)
			user.reload

			expect(user.songs[0].song_number).to eq(1)
			expect(user.songs[0].url).to eq("song1_url")
			expect(user.songs[0].song_name).to eq("My Song 1")

			expect(user.songs[1].song_number).to eq(2)
			expect(user.songs[1].url).to eq("song3_url")
			expect(user.songs[1].song_name).to eq("My Song 3")
		end
	end
end
describe Song do
	let(:song) { FactoryGirl.create(:song) }

	it 'has a valid factory' do
		expect(song).to be_valid
	end

	it 'has a name' do
		expect(song.song_name).to_not eq(nil)
	end

	it 'has a url' do
		expect(song.url).to_not eq(nil)
	end

	it 'has a song number' do
		expect(song.song_number).to_not eq(nil)
	end
end
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

	context 'class methods' do
		let(:song_mp3) { FactoryGirl.create(:song_with_ext_in_name, :mp3)}
		let(:song_mpeg) { FactoryGirl.create(:song_with_ext_in_name, :mpeg)}
		let(:song_m4a) { FactoryGirl.create(:song_with_ext_in_name, :m4a)}

		it '#remove_extension removes the extension from the file name' do
			expect(song_mp3.song_name[".mp3"]).to eq(nil)
			expect(song_m4a.song_name[".m4a"]).to eq(nil)
			expect(song_mpeg.song_name[".mpeg"]).to eq(nil)
		end
	end
end
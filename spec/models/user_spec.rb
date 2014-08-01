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
		expect(user.state).to_not eq(nil)
	end

	it 'can store street' do
		expect(user.state).to_not eq(nil)
	end

	it 'can give lessons' do
		expect(FactoryGirl.create(:user, :can_give_lessons).lessons).to eq(true)
	end

	it 'has genres' do
		expect(FactoryGirl.create(:user, :has_genres).genres).to eq("Rock, Classical, World")
	end

	it 'has a personal statement' do
		expect(FactoryGirl.create(:user, :has_personal_statement).statement).to eq("I love Jammer!")
	end

	it 'has uploaded songs' do
		expect(FactoryGirl.create(:user_with_a_song).songs).to_not eq(nil)
	end
end
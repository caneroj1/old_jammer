describe Message do
	let(:message) { FactoryGirl.build(:message) }
	let(:message_two) { FactoryGirl.build(:message, :for_lessons) }

	it 'has a valid lesson factory' do
		expect(FactoryGirl.create(:message, :for_lessons)).to be_valid
	end

	it 'has a valid jam factory' do
		expect(FactoryGirl.create(:message, :for_jam)).to be_valid
	end

	it 'has a valid booking factory' do
		expect(FactoryGirl.create(:message, :for_booking)).to be_valid
	end

	it 'is invalid without a request type' do
		expect(message).to_not be_valid
	end

	it 'has a message body' do
		expect(message_two.message_body).to_not eq(nil)
	end

	it 'has a sent by attribute' do
		expect(message_two.sent_by.class).to eq(Fixnum)
	end

	it 'has a subject' do
		expect(message_two.subject).to_not eq(nil)
	end

	it 'is invalid without a subject' do
		expect(FactoryGirl.build(:message, subject: nil)).to_not be_valid
	end

	it 'is invalid without a message body' do
		expect(FactoryGirl.build(:message, message_body: nil)).to_not be_valid
	end

	it 'can have replies' do
		expect(FactoryGirl.build(:message_with_replies).replies).to_not eq(nil)
	end

	it 'belongs to a user' do
		expect(FactoryGirl.build(:sent_message).users).to_not eq(nil)
	end
end
require 'faker'

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

	context 'class methods' do
		let(:time) { Time.now }
		let(:message_with_users) { FactoryGirl.create(:message_with_users, :for_jam, created_at: time) }

		it '#first_names can return an array of first names' do
			expect(message_with_users.first_names).to eq("joe, john")
		end

		it '#uid returns the index of the passed in id' do
			id = message_with_users.users[0].id
			expect(message_with_users.uid(id)).to eq(0)

			id = message_with_users.users[1].id
			expect(message_with_users.uid(id)).to eq(1)
		end

		it '#sender returns the name of the sender' do
			expect(message_with_users.sender).to eq("joe canero")
		end

		it '#first_name returns the first name of the sender' do
			expect(message_with_users.first_name).to eq("joe")
		end

		it '#sender_picture returns the avatar url of the user who sent the message' do
			expect(message_with_users.sender_picture.class).to eq(Faker::Internet.url.class)
		end

		it '#type? returns the type of message' do
			expect(message_with_users.type?).to eq("Jam Request")
		end

		it '#receiver returns the user who received the message' do
			expect(message_with_users.receiver.class).to eq(User)
		end

		it '#receiver_picture returns the avatar url of the user who received the message' do
			expect(message_with_users.receiver_picture.class).to eq(Faker::Internet.url.class)
		end

		it '#last_active_time returns the time of last activity' do
			expect(message_with_users.last_active_time).to eq(time.strftime("%-m/%d/%Y, %l:%M, %P"))
		end
	end
end
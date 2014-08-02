require 'faker'

describe Reply do
	let(:reply) { FactoryGirl.build(:reply) }

	it 'has a valid factory' do
		expect(reply).to be_valid
	end

	it 'has a body' do
		expect(reply.reply_body).to_not eq(nil)
	end

	it 'has a sent by attribute' do
		expect(reply.sent_by.class).to eq(Fixnum)
	end

	context 'class methods' do
		let(:reply_two) { FactoryGirl.create(:reply_with_sender) }

		it '#sent_name returns the first name of the user who sent the message' do
			expect(reply_two.sent_name).to eq("joe")
		end

		it '#sender_picture returns the avatar url of the sender' do
			expect(reply_two.sender_picture.class).to eq(Faker::Internet.url.class)
		end
	end
end
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
end
describe RepliesController do
	let(:message) { FactoryGirl.create(:message, :for_jam) }
	let(:user) { FactoryGirl.create(:user) }

	describe "#create_reply" do
		it 'creates a reply for a given message' do
			sign_in user
			expect { post "create_reply", format: :json, reply: { reply_body: "Hello", sent_by: user.id, message_id: message.id }, musician_id: user.id, id: user.id }.to change(Reply, :count).by 1 
		end
	end
end
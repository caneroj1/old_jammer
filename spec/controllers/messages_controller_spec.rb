include Devise::TestHelpers

describe MessagesController do
	describe "#create" do
		let (:user) { FactoryGirl.create(:user) }
		let (:good_message) { FactoryGirl.build(:message, sent_by: user.id) }
		let (:bad_message) { FactoryGirl.build(:message, sent_by: user.id) }

		before :each do
			sign_in user
		end

		it 'should redirect to musician path upon success' do
			post :create, musician_id: user.id, message: { subject: good_message.subject, message_body: good_message.message_body, sent_by: good_message.sent_by }, request: "jam"
			expect(response).to redirect_to musician_path(user)
		end

		it 'should render the contact form upon failure' do
			post :create,  musician_id: user.id, message: { subject: good_message.subject, message_body: good_message.message_body, sent_by: good_message.sent_by }
			expect(response).to render_template 'musicians/contact'
		end

		it 'saves a message upon success' do
			expect { post :create, musician_id: user.id, message: { subject: good_message.subject, message_body: good_message.message_body, sent_by: good_message.sent_by }, request: "jam"}.to change(Message, :count).by(1)
		end

		it 'does not save a message upon failure' do
			expect { post :create, musician_id: user.id, message: { subject: good_message.subject, message_body: good_message.message_body, sent_by: good_message.sent_by } }.to_not change(Message, :count)
		end
	end
end
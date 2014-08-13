describe MusiciansController do
	let(:user) { FactoryGirl.create(:user, :can_give_lessons) }
	let(:user_with_genres) { FactoryGirl.create(:user, :has_genres) }

	before :each do
		sign_in user
	end

	describe "#show" do
		it 'renders the musician homepage' do
			get :show, id: user.id

			expect(response).to render_template 'musicians/show'
		end
	end

	describe "#edit" do
		it 'renders the edit profile page' do
			get :edit, id: user.id

			expect(response).to redirect_to '/users/edit'
		end
	end

	describe "#update" do
		context 'with changes to lessons' do
			it 'updates the user\'s lesson status' do
				put :update, user: { lessons: false }, id: user.id

				user.reload

				expect(user.lessons).to eq(false)
			end
		end

		context 'with changes to statement' do
			it 'updates the user\'s statement' do
				put :update, user: { statement: "I am the Lord of Winterfell." }, id: user.id

				user.reload

				expect(user.statement).to eq("I am the Lord of Winterfell.")
			end
		end

		context 'with changes to location' do 
			context 'change to city' do
				it 'changes only the city' do
					prev_state, prev_street = user.state, user.street
					put :update, user: { city: "Riverrun", hidden: true }, id: user.id

					user.reload

					expect(user.city).to eq("Riverrun")
					expect(user.state).to eq(prev_state)
					expect(user.street).to eq(prev_street)
				end
			end

			context 'change to state' do
				it 'changes only the state' do
					prev_city, prev_street = user.city, user.street
					put :update, user: { state: "Dorne", hidden: true }, id: user.id

					user.reload

					expect(user.state).to eq("Dorne")
					expect(user.city).to eq(prev_city)
					expect(user.street).to eq(prev_street)
				end
			end

			context 'change to street' do
				it 'changes only the street' do
					prev_state, prev_city = user.state, user.city
					put :update, user: { street: "Flea Bottom", hidden: true }, id: user.id

					user.reload

					expect(user.street).to eq("Flea Bottom")
					expect(user.state).to eq(prev_state)
					expect(user.city).to eq(prev_city)
				end
			end

			context 'change whole address' do
				it 'changes all location fields' do
					put :update, user: { street: "Gin Alley", city: "King's Landing", state: "The Crownlands", hidden: true }, id: user.id

					user.reload

					expect(user.street).to eq("Gin Alley")
					expect(user.city).to eq("King's Landing")
					expect(user.state).to eq("The Crownlands")
				end
			end
		end

		context 'with changes to genres' do
			it 'updates the user\'s genres' do
				put :update, user: { g1: "Swing", g2: "Funk" }, id: user.id

				user.reload

				expect(user.neat_genres).to eq("Swing, Funk")
			end

			it 'appends to existing genres' do
				put :update, user: { g1: "Swing", g2: "Funk" }, id: user_with_genres.id

				user_with_genres.reload

				expect(user_with_genres.neat_genres).to eq("Swing, Funk,  Rock, Classical, World")
			end
		end
	end

	describe "#contact" do
		it 'renders the contact form' do
			get :contact, id: user.id

			expect(response).to render_template "musicians/contact"
		end
	end

	describe "#messages" do
		it 'renders the messages view' do
			get :messages, id: user.id

			expect(response).to render_template "musicians/messages"
		end
	end

	describe "#songs" do
		it 'renders the songs view' do
			get :songs, id: user.id

			expect(response).to render_template "musicians/songs"
		end
	end
end
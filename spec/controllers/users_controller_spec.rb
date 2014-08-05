describe UsersController do
	before :each do
		@request.env["devise.mapping"] = Devise.mappings[:user]
	end

	describe "#new" do
		it 'renders the new page' do
			get :new
			expect(response).to render_template 'devise/registrations/new'
		end
	end

	describe "#create" do
		context 'with valid attributes' do
			it 'saves the object in the database' do
				expect { post :create, user: FactoryGirl.attributes_for(:user) }.to change(User, :count).by(1)
			end

			it 'redirects to the profile page' do
				post :create, user: FactoryGirl.attributes_for(:user)
				expect(response).to redirect_to("/")
			end
		end

		context 'with invalid attributes' do
			it 'does not save the new object' do
				expect { post :create, user: FactoryGirl.attributes_for(:invalid_user) }.to_not change(User, :count)
			end

			it 'redirect to the registration page' do
				post :create, user: FactoryGirl.attributes_for(:invalid_user)
				expect(response).to render_template 'devise/registrations/new'
			end
		end
	end

	describe "#update" do
		let (:user) { FactoryGirl.create(:user, first_name: "bob", last_name: "beefcake") }
		
		before :each do
			sign_in user
		end

		context 'with valid attributes' do
			it 'updates the user\'s email' do
				put :update, user: FactoryGirl.attributes_for(:user, email: "tyrion.lannister@westeros.org")
				
				user.reload
				
				expect(user.email).to eq("tyrion.lannister@westeros.org")
			end

			it 'redirects to the edit page' do
				put :update, user: FactoryGirl.attributes_for(:user, email: "tyrion.lannister@westeros.org")
			
				expect(response).to redirect_to(edit_user_registration_path)
			end
		end

		context 'with invalid attributes' do
			it 'does not update the user\'s email' do
				expect { put :update, user: FactoryGirl.attributes_for(:user, email: "") }.to_not change(User, :count)
			end
		end
	end

	describe "#update_password" do
		let (:user) { FactoryGirl.create(:user) }
		context 'with valid attributes' do

		end
	end
end
describe UsersController do
	describe "#new" do
		before :each do
			@request.env["devise.mapping"] = Devise.mappings[:user]
		end


		it 'renders the new page' do
			get :new
			expect(response).to render_template '/users/sign_up'
		end
	end
end
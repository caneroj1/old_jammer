describe WelcomeController do
	it 'renders the homepage' do
		get :index

		expect(response).to render_template "/"
	end
end
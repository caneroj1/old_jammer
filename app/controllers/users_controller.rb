class UsersController < Devise::RegistrationsController
	def new
		@instrument_list = instrument_list
		@state_list = state_list
		super
	end
end

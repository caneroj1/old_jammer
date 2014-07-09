class UsersController < Devise::RegistrationsController
	
	## override the new/create methods for a registration controller in order
	# to pass new instance variables to the view
	def new
		@instrument_list = instrument_list
		@state_list = state_list
		super
	end

	def create
		@instrument_list = instrument_list
		@state_list = state_list
		super
	end

	## redirect the current user to musicians#show
	# to display current user as a musician
	def profile

	end
end

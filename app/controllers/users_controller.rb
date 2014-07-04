class UsersController < Devise::RegistrationsController
	
	## override the new method for a registration controller in order
	# to pass new instance variables to the view
	def new
		@instrument_list = instrument_list
		@state_list = state_list
		super
	end
end

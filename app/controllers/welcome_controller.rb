class WelcomeController < ApplicationController
	def index
		enable_devise
		@display_nav, @display_search = user_signed_in?, true
		@state_list = state_list
		@instrument_list = instrument_list
	end
end

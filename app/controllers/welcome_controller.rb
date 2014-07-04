class WelcomeController < ApplicationController
	def index
		enable_devise
		@state_list = state_list
		@instrument_list = instrument_list
	end
end

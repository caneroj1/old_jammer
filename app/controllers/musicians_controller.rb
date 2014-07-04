class MusiciansController < ApplicationController
	respond_to :html

	# get the user object as specified by the id in params
	def show
		@musician = User.find_by_id(params[:id])
		respond_with @musician
	end
end

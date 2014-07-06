class MusiciansController < ApplicationController
	respond_to :html

	# get the user object as specified by the id in params
	def show
		@musician = User.find_by_id(params[:id])
		respond_with @musician
	end

	def update
		@musician = User.find_by_id(current_user)
		# check if an image is being uploaded
		if params[:user][:avatar]
			@musician.avatar = params[:user][:avatar]
			@musician.uploaded = true
		else # if no image is being uploaded: this is for regular info changing
			puts "hello"
		end

		if @musician.save
			redirect_to musician_path(@musician)
		else
			@musician.uploaded = false if params[:user][:avatar]
			render 'show'
		end
	end

	# this will control the contact process for the musician
	def contact
		@musician = User.find_by_id(params[:id])
	end
end

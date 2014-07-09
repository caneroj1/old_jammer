class MusiciansController < ApplicationController
	respond_to :html

	# get the user object as specified by the id in params
	def show
		@musician = User.find_by_id(params[:id])
		respond_with @musician
	end

	def update
		@musician = User.find_by_id(current_user)
		params[:user] ||= {}

		# check if an image is being uploaded
		if !params[:user][:avatar].eql?("nothing")
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
		@message = Message.new

		# if there is a user signed in, attribute the message made to both musicians
		@message.sent_by = current_user.id if user_signed_in?
	end
end

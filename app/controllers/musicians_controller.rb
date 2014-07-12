class MusiciansController < ApplicationController
	respond_to :html, :js

	# get the user object as specified by the id in params
	def show
		@musician = User.find_by_id(params[:id])
		respond_with @musician
	end

	def edit
		enable_devise
	end

	def update
		@musician = User.find_by_id(params[:id])

		# is the user changing their lesson giving status?
		if params[:user].key?(:lessons)
			@musician.lessons = params[:user][:lessons]
		end

		if @musician.save
			redirect_to '/users/edit'
		else
			render '/users/edit'
		end
	end

	## upload a profile picture
	def upload
		@musician = User.find_by_id(current_user)
		if !params[:user].nil?
			@musician.avatar = params[:user][:avatar]
			@musician.uploaded = true
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

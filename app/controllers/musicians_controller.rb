class MusiciansController < ApplicationController
	respond_to :html, :js

	# before updating, processing the params hash
	# in order to organize the genres that may have been submitted
	before_filter :process_genres, :only => [:update] 


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
		updated = ""

		# is the user changing their lesson giving status?
		if params[:user].key?(:lessons)
			@musician.lessons = params[:user][:lessons]
			updated = "lessons"
		# update statement for the user
		elsif params[:user].key?(:statement)
			@musician.statement = params[:user][:statement]
			updated = "statement"
		# update the user's genres
		elsif params[:user].key?(:genres)
			# results stores the concatenation of the genres submitted from the form
			results = params[:user][:genres]

			# we want to only add genres for the user that they do not already have
			# as well as keep the ones they have added
			@musician.genres = process_results(results, @musician) + @musician.genres
			updated = "genres"
		end

		if @musician.save
			redirect_to edit_user_registration_path(updated: updated)
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

	# this will display all of the user's messages
	def messages
		@musician = User.find_by_id(params[:id])
		@messages = @musician.messages
	end

	# this will display all of the user's songs
	def songs
		@musician = User.find_by_id(current_user.id)

		#### move this to a helper ####
		@songs = Jammer::Uploader.get_user_songs(current_user.id, current_user.uploaded_songs)
	end

	private
	def process_genres
		# clear the genres key and value pair that was a hidden field from the form
		params[:user][:genres] = ""

		# concatenate the genres value with whatever genres the user has submitted, space delimited
		params[:user][:genres] << params[:user][:g1] << "," unless params[:user][:g1].nil?
		params[:user][:genres] << params[:user][:g2] << "," unless params[:user][:g2].nil? 
		params[:user][:genres] << params[:user][:g3] << "," unless params[:user][:g3].nil? 
		params[:user][:genres] << params[:user][:g4] << "," unless params[:user][:g4].nil? 
		params[:user][:genres] << params[:user][:g5] << "," unless params[:user][:g5].nil? 
	end

	# split the result of process_genres by space and loop through them
	# only prepare to add the genre to the user if the user does not already have
	# that genre listed
	def process_results(result, musician)
		genre_array, new_str = result.split(' '), ""
		genre_array.each do |genre|
			new_str << genre << " " if musician.genres[genre].nil?
		end
		new_str
	end
end

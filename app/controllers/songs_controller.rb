class SongsController < ApplicationController

	# this method will handle the uploading of an audio file to aws s3.
	# each user has a 5 song limit right now, so if the user has reached that limit they cannot upload the next song
	# the file that they upload must also be an mp3 file.
	def upload
		user = User.find_by_id(params[:id])

		mp3 = uploaded_file?(params) ? is_mp3?(params[:user][:song_file]) : nil
		under_five = under_five_songs?(user)
		puts mp3
		if under_five && mp3
			user.uploaded_songs += 1
			url = Jammer::Uploader.upload_song(params[:user][:song_file],
																	 user.id,
																	 user.uploaded_songs)

			user.songs.new(song_name: params[:user][:song_file].original_filename,
										 url: url.to_s,
										 song_number: user.uploaded_songs)

			user.save
			success_message "Thank you for uploading some audio!"
		else
			failure_message(mp3, under_five)
		end
		redirect_to songs_musician_path(user)
	end	

	# this method will handle uploading thumbnail images to the song
	def upload_thumb
		song = User.find_by_id(params[:id]).get_song_by_number(params[:song_number])
		if !params[:thumb].nil?
			song.thumb = params[:thumb]
			song.save
			flash[:upload_success] = "Thumbnail successfully uploaded!"
		else
			flash[:upload_error] = "There was a problem uploading that file"
		end

		redirect_to songs_musician_path(current_user)
	end

	# remove the song from the user's library
	def remove
		user = User.find_by_id(params[:id])

		urls = Jammer::Uploader.remove_song(user.id, params[:song_number])
		user.remove_song(params[:song_number], urls)

		user.uploaded_songs -= 1
		user.save

		success_message "Song successfully removed!"

		redirect_to songs_musician_path(current_user)
	end

	private
	def is_mp3?(file)
		%w{ audio/x-m4a audio/mp3 audio/mpeg }.include?(file.content_type)
	end

	def under_five_songs?(user)
		user.uploaded_songs < 5
	end

	def uploaded_file?(params)
		params.key?(:user)
	end

	def success_message(message)
		flash[:success] = message
	end

	def failure_message(mp3, under_five)
		flash[:failure] = 
		if mp3.nil? || !mp3
			"Please upload either an mp3, mp4, or mpeg file."
		elsif !under_five
			"You have reached your 5 song limit."
		end
	end
end

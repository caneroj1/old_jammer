class SongsController < ApplicationController

	# this method will handle the uploading of an audio file to aws s3.
	# each user has a 5 song limit right now, so if the user has reached that limit they cannot upload the next song
	# the file that they upload must also be an mp3 file.
	def upload
		user = User.find_by_id(params[:id])

		mp3 = uploaded_file?(params) ? is_mp3?(params[:user][:song_file]) : nil
		under_five = under_five_songs?(user)

		if under_five && !mp3.nil?
			url = Jammer::Uploader.upload_song(params[:user][:song_file],
																	 user.id,
																	 user.uploaded_songs)

			user.songs.new(song_name: params[:user][:song_file].original_filename.sub(".mp3", ""),
										 url: url.to_s,
										 song_number: user.uploaded_songs)

			user.uploaded_songs += 1
			user.save
			success_message
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

	private
	def is_mp3?(file)
		file.content_type.eql?("audio/mp3")
	end

	def under_five_songs?(user)
		user.uploaded_songs < 5
	end

	def uploaded_file?(params)
		params.key?(:user)
	end

	def success_message
		flash[:success] = "Thank you for uploading some audio!"
	end

	def failure_message(mp3, under_five)
		flash[:failure] = 
		if mp3.nil? || !mp3
			"Please upload an mp3."
		elsif !under_five
			"You have reached your 5 song limit."
		end
	end
end

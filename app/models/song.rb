class Song < ActiveRecord::Base
	# after a song has been created, remove the extension from the filename
	before_save :remove_extension

	# each user has songs
	belongs_to :user

	attr_accessible :song_name,
									:url,
									:song_number

	# a song will have a thumbnail associated with it
	# this is handled by the thumb uploader
	mount_uploader :thumb, ThumbUploader

	def remove_extension
		song_name.sub!(/.m4a|.mpeg|.mp3/, "")
	end
end

class Song < ActiveRecord::Base
	# each user has songs
	belongs_to :user

	attr_accessible :song_name,
									:url,
									:song_number

	# a song will have a thumbnail associated with it
	# this is handled by the thumb uploader
	mount_uploader :thumb, ThumbUploader
end

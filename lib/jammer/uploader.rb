module Jammer
	class Uploader
		# return the s3 object that points to the jammer account
		# this will be used for uploading videos and songs
		def self.return_aws_object
			s3 = AWS::S3.new( :access_key_id => ENV['ACCESS_KEY_ID'],
												:secret_access_key => ENV['SECRET_ACCESS_KEY'])
			define_buckets(s3)
		end

		# this method will define buckets for uploading songs and videos
		# if the buckets do not already exist
		def self.define_buckets(s3)
			s3.buckets.create("#{Rails.env.to_s}_songs") unless s3.buckets["#{Rails.env.to_s}_songs"].exists?
			s3.buckets.create("#{Rails.env.to_s}_vids") unless s3.buckets["#{Rails.env.to_s}_vids"].exists?
			s3
		end

		# upload a song to the song bucket
		# songs are indexed by "user_id"_song"song_number"
		# for example, if user 33 is uploading their 5th song, the index will be
		# 33_song5
		def self.upload_song(song, user_id, song_number)
			s3 = return_aws_object
			s3.buckets["#{Rails.env.to_s}_songs"].objects["#{user_id}_song#{song_number}"].write(song.read)
			s3.buckets["#{Rails.env.to_s}_songs"].objects["#{user_id}_song#{song_number}"].url_for(:get, expires: "Jan 2030")
		end

		# upload a video to the video bucket
		# videos are indexed by "user_id"_videos"video_number"
		# for example, if user 33 is uploading their 5th video, the index will be
		# 33_vids5
		def self.upload_video(video, user_id, video_number)
			s3 = return_aws_object
			s3.buckets["#{Rails.env.to_s}_vids"].objects["#{user_id}_vids#{video_number}"].write(video.read)
			s3.buckets["#{Rails.env.to_s}_vids"].objects["#{user_id}_vid#{video_number}"].url_for(:get, expires: "Jan 2030")
		end

		# remove a song from the song bucket
		# get the properly indexed song and delete it
		# rename all songs indexed above the deleted song one number lower
		# returns the new urls for the renamed objects
		def self.remove_song(user_id, song_number)
			s3 = return_aws_object
			s3.buckets["#{Rails.env.to_s}_songs"].objects["#{user_id}_song#{song_number}"].delete

			new_urls = []
			(5 - song_number.to_i).times do |number|
				if s3.buckets["#{Rails.env.to_s}_songs"].objects["#{user_id}_song#{song_number.to_i + number.to_i}"].exists?
					s3.buckets["#{Rails.env.to_s}_songs"].objects["#{user_id}_song#{song_number.to_i + number}"].move_to("#{user_id}_song#{song_number.to_i + number - 1}")
					new_urls << s3.buckets["#{Rails.env.to_s}_songs"].objects["#{user_id}_song#{song_number.to_i + number - 1}"].url_for(:get, expires: "Jan 2030")
				end
			end
			new_urls
		end

		private
		def sanitize_filename(file_name)
		    just_filename = File.basename(file_name)
		    just_filename.sub(/[^\w\.\-]/,'_')
		end
	end
end
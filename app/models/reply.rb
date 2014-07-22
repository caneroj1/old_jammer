class Reply < ActiveRecord::Base
	# a reply belongs to a single message
	belongs_to :message

	attr_accessible :sent_by,
									:reply_body


	# first name of the user who sent the message
	def sent_name
		User.find_by_id(sent_by).first_name
	end

	# def sender_picture
	def sender_picture
		user = User.find_by_id(sent_by)
    user.avatar_url
	end
end

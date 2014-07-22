class Reply < ActiveRecord::Base
	# a reply belongs to a single message
	belongs_to :message

	attr_accessible :sent_by,
									:reply_body
end

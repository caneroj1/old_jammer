module RepliesHelper

	# returns the classes on the div depending on if the message to be displayed
	# was sent by the current user or not
	def original_message(uid, mid)
		uid.eql?(mid) ? "col-xs-offset-2 col-xs-9 reply-r" : "col-xs-9 col-xs-offset-1 reply-l"
	end

	def sent_by_me?(uid, mid)
		uid.eql?(mid) ? true : false
	end
end

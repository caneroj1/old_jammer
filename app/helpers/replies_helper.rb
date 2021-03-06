module RepliesHelper

	# returns the classes on the div depending on if the message to be displayed
	# was sent by the current user or not
	def original_message(uid, mid)
		uid.eql?(mid) ? "col-xs-offset-2 col-xs-9 reply-r reply" : "col-xs-9 col-xs-offset-1 reply-l reply"
	end

	def sent_by_me?(uid, mid)
		uid.eql?(mid) ? true : false
	end

	# returns the time this reply was sent
	def reply_time(reply)
		reply_time = reply.created_at
		response = what_time_to_show?(reply_time)
		case response
		when "minutes"
			reply_time.localtime.strftime("%l:%M,  %P")
		when "months"
			reply_time.localtime.strftime("%-m/%e")
		when "years"
			reply_time.localtime.strftime("%-m/%Y")
		end
	end

	# if the time the message was created is more than 5 minutes ago,
	# we should display the time the reply was created
	def show_time?(reply)
		(Time.now - reply.created_at.localtime) > 300.0
	end

	# if the reply was created at least a day ago, only show the month and date
	# if the reply was created at least a year ago, show day, month, and year
	# else, show minutes and seconds
	def what_time_to_show?(reply_time)
		now = Time.now
		if (now - reply_time.localtime) < (60 * 60 * 24)
			"minutes"
		elsif (now - reply_time.localtime) < (60 * 60 * 24 * 365)
			"months"
		else
			"years"
		end
	end
end

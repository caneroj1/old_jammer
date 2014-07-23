module MessagesHelper
	# returns the time this message was sent
	# the time displayed is dependent upon the time the
	# message was sent
	def message_time(message)
		message_time = message.created_at
		response = what_time_to_show?(message_time)
		case response
		when "minutes"
			message_time.strftime("%l:%M,  %P")
		when "months"
			message_time.strftime("%-m/%e")
		when "years"
			message_time.strftime("%-m/%Y")
		end
	end

	# if the message was created at least a day ago, only show the month and date
	# if the message was created at least a year ago, show day, month, and year
	# else, show minutes and seconds
	def what_time_to_show?(message_time)
		now = Time.now
		if (now - message_time) < (60 * 60 * 24)
			"minutes"
		elsif (now - message_time) < (60 * 60 * 24 * 365)
			"months"
		else
			"years"
		end
	end
end

class MessagesController < ApplicationController

	## the create method for the message
	# it will handle the processing from the contact form
	def create
		@musician = User.find_by_id(params[:musician_id])
		@message = Message.create(params[:message])

		sender = User.find(params[:message][:sent_by])

		## fill in the request type of the message
		case params[:request]
		when "lesson"
			@message.lesson_request = true
		when "jam"
			@message.jam_request = true
		when "booking"
			@message.booking_request = true
		end
		
		## if the message is saved, redirect to the profile of the
		# musician to whom the message was sent
		if @message.save
			@musician.messages << @message
			sender.messages << @message unless sender.nil?
			redirect_to musician_path(@musician)
		else
			if @message.errors.messages.keys.include?(:lesson_request)
				@message.errors.delete(:lesson_request)
				@message.errors.delete(:jam_request)
				@message.errors.delete(:booking_request)
				@message.errors.add(:message_type, "must be chosen")
			end
			render "musicians/contact"
		end
	end

	# this will return the message in neatly formatted haml
	# package that can simply be added to the message display
	# pane in the messages page
	def get_message
		message = Message.find_by_id(params[:m_id])
		reply = Reply.new
		render partial: "partials/message/message", locals: { message: message, reply: reply }
	end

	# this will return the reply in neatly formatted haml
	# package that can simply be appended to the list of replies
	# on the message page
	def get_reply
		message = Message.find_by_id(params[:m_id])
		reply = params[:r_id] ? message.replies.find(params[:r_id]) : message.replies.last
		render partial: "partials/replies/reply", locals: { message: message, reply: reply }
	end

	# return the ids of the last created messages that the page sending the request
	# doesn't have
	def last_created_reply
		message = Message.find_by_id(params[:m_id])
		replies = message.replies.last(message.replies.count - params[:reply_count].to_i)

		# maps the reply_ids variable into an empty array or a array of hashes
		# containing the id of the reply and the id of the user who sent it
		reply_ids = 
		if replies.empty?
			[]
		else
			replies.map { |r| { :id => r.id, :sent_by => r.sent_by } }
		end

		respond_to do |format|
			format.json { render :json => { replies: reply_ids, new_count: message.replies.count } }
		end
	end
end

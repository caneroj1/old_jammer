class MessagesController < ApplicationController

## the create method for the message
# it will handle the processing from the contact form
def create
	@message = Message.new
	@musician = User.find_by_id(params[:musician_id])

	## determine to whom the message belongs
	# if there is a sent_by field, that means it came from an active user
	# else it is from someone without an account
	if params[:sent_by]
		@message.sent_by = params[:sent_by]
	else
		@message.sent_by = params[:return_email]
	end

	## fill in the request type of the message
	case params[:request]
	when "lesson"
		@message.lesson_request = true
	when "jam"
		@message.jam_request = true
	when "booking"
		@message.booking_request = true
	end
		
	@message.message_body = params[:message_body]
	if @message.save
		redirect_to musician_path(params[:musician_id])
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

end

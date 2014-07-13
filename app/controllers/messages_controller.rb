class MessagesController < ApplicationController

## the create method for the message
# it will handle the processing from the contact form
def create
	@musician = User.find_by_id(params[:musician_id])
	@message = Message.create(params[:message])

	# if the request is sent from a logged in user
	sender = User.find(params[:message][:sent_by]) if params[:message][:sent_by]

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

end

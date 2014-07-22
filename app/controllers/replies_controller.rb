class RepliesController < ApplicationController
	
	# this creates a reply for a given message
	# this form is filled out from the messages page
	def create_reply
		@message = Message.find_by_id(params[:reply][:message_id])
		params[:reply].delete(:message_id)
		reply = @message.replies.new(params[:reply])
		reply.save
		respond_to do |format|
			format.json { render json: "Success!", status: :ok }
		end
	end
end

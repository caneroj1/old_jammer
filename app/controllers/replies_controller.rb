class RepliesController < ApplicationController
	
	# this creates a reply for a given message
	# this form is filled out from the messages page
	def create_reply
		@message = Message.find_by_id(params[:reply][:message_id])
		params[:reply].delete(:message_id)
		reply = @message.replies.new(params[:reply])
		reply.save
		respond_to do |format|
			format.json { render json: { reply_id: reply.id,
																	 body: reply.reply_body,
																	 time: reply.created_at,
																	 sender: reply.sent_by,
																	 name: reply.sent_name,
																	 avatar: current_user.avatar_url }, status: :ok }
		end
	end
end

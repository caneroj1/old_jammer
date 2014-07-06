class Message < ActiveRecord::Base
	## messages are sent to musicians for a few reasons:
	# 1) an interest in taking lessons from a musician
	# 2) an interest in booking the musician for a gig
	# 3) an interest in jamming/practicing with a musician
  # or inviting them to a band

  # a message belongs to a musician
  belongs_to :user

  attr_accessible :return_email, # this will be used if whoever is contacting the musician has no account
  								:message_body,
  								:lesson_request,
  								:jam_reqest,
  								:booking_request,
  								:sent_by			# this will be the id of the user who sent the message

  # the message should be a type of request
  validates :lesson_request, presence: true, 	if: "jam_request.nil? && booking_request.nil?"
  validates :jam_request, presence: true, 		if: "lesson_request.nil? && booking_request.nil?"
  validates :booking_request, presence: true, if: "jam_request.nil? && lesson_request.nil?"
  
end

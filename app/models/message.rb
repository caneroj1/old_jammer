class Message < ActiveRecord::Base
	## messages are sent to musicians for a few reasons:
	# 1) an interest in taking lessons from a musician
	# 2) an interest in booking the musician for a gig
	# 3) an interest in jamming/practicing with a musician
  # or inviting them to a band

  # a message belongs to a musician
  has_and_belongs_to_many :users

  attr_accessible :return_email, # this will be used if whoever is contacting the musician has no account
                  :subject,
  								:message_body,
  								:lesson_request,
  								:jam_request,
  								:booking_request,
  								:sent_by			# this will be the id of the user who sent the message

  # the message should be a type of request
  validates :lesson_request, presence: true, 	if: "jam_request.nil? && booking_request.nil?"
  validates :jam_request, presence: true, 		if: "lesson_request.nil? && booking_request.nil?"
  validates :booking_request, presence: true, if: "jam_request.nil? && lesson_request.nil?"
  validates :message_body, presence: true
  validates :subject, presence: true

  def first_names
    str = ''
    users.each { |u| str << u.first_name << " " }
    str.strip.split(" ").join(', ')
  end

  def uid(id)
    users.find_index { |u| u.id.eql?(id)}
  end

  def sender
    user = User.find_by_id(sent_by)
    "#{user.first_name} #{user.last_name}"
  end

  def sender_picture
    user = User.find_by_id(sent_by)
    user.uploaded ? user.avatar.url : image_url("no_avatar.png")
  end
end

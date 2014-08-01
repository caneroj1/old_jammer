class Message < ActiveRecord::Base
	## messages are sent to musicians for a few reasons:
	# 1) an interest in taking lessons from a musician
	# 2) an interest in booking the musician for a gig
	# 3) an interest in jamming/practicing with a musician
  # or inviting them to a band

  # a message belongs to a musician
  has_and_belongs_to_many :users
  # a message has many replies. 
  has_many :replies

  attr_accessible :subject,
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

  # returns an array of first names of the users associated with this
  # message
  def first_names
    str = ''
    users.each { |u| str << u.first_name << " " }
    str.strip.split(" ").join(', ')
  end

  # returns index of the user in the array with the passed in id
  def uid(id)
    users.find_index { |u| u.id.eql?(id)}
  end

  # returns the name of the user who sent the message
  def sender
    user = User.find_by_id(sent_by)
    "#{user.first_name} #{user.last_name}"
  end

  # first name of the message sender
  def first_name
    user = User.find_by_id(sent_by).first_name
  end

  # returns the url to the avatar of the sender
  def sender_picture
    user = User.find_by_id(sent_by)
    user.avatar_url
  end

  # returns the type of message
  def type?
    lesson_request.nil? ? jam_request.nil? ? booking_request.nil? ? "No Type" : "Booking Request" : "Jam Request" : "Lesson Request"
  end

  # returns the user who received the message
  def receiver
    users[0].id.eql?(sent_by) ? users[1] : users[0]
  end

  # returns the url to the avatar of the receiver of the message
  def receiver_picture
    user = users.select { |user| !user.id.eql?(sent_by) }.first
    user.avatar_url
  end

  # returns the most recent time of activity for this message
  # if the message has no replies, it is the time this message was created
  # otherwise it is the time of creation of the last reply
  def last_active_time
    time = replies.any? ? replies.last.created_at.localtime : created_at.localtime
    time.strftime("%-m/%d/%Y, %l:%M, %P")
  end
end

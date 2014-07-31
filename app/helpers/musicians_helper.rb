module MusiciansHelper 

	# should we show the avatar upload form?
	# we show it if there is a user signed in, they are on their own
	# profile page and they haven't uploaded a picture.
	# otherwise, just show the avatar picture
	def show_avatar_upload?(musician)
		if user_signed_in?
			musician.id.eql?(current_user.id) && !musician.uploaded
		else
			false
		end
	end

	def link_to_contact?(musician)
		if user_signed_in?
			!musician.id.eql?(current_user.id)
		else
			true
		end
	end
end

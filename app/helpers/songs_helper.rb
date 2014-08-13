module SongsHelper

	def remove_link?(page, song)
		if page.eql?("songs")
			link_to song_remove_musician_path(id: current_user.id, song_number: song.song_number), method: :post, class: :remove do
				content_tag(:span, "Remove", class: "glyphicon glyphicon-remove")
			end
		end
	end

	def uploaded?(page, song)
		if page.eql?("songs")
			content_tag(:small, "Uploaded #{song.created_at.strftime('%-m/%d')}")
		end
	end

	def upload_link(song)
		link_to "Upload", "#", :data => { toggle: "modal", target: "#upload-thumb", number: song.song_number }, class: :pic_link
	end

	def thumbnail(song)
		content_tag(:span, "", class: "glyphicon glyphicon-camera span_pic")
	end

	def show_img_upload?(page, song)
		if page.eql?("songs")
			content_tag(:p, "", class: "picture-inside") do
				upload_link(song) << thumbnail(song)
			end
		end
	end

	def empty_song_content(empty, page)
		if page.eql?("songs")
			empty ? content_tag(:p, "You have not uploaded any songs. Use the form to the right to upload them") : ""
		else
			empty ? content_tag(:h3, "No songs have been uploaded yet.") : ""
		end
	end
end

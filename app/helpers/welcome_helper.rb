module WelcomeHelper
	def content_for_email_errors
		tag = content_tag(:div, "")
		if @musician.errors.any?
  		@musician.errors.each { |key, val| tag.concat(content_tag(:div, key.to_s.capitalize << " " << val, class: "errors")) if key.eql?(:email) }
    end
    tag
	end

	def content_for_password_errors
		tag = content_tag(:div, "")
		if @musician.errors.any?
			puts @musician.errors.inspect
  		@musician.errors.each { |key, val| tag.concat(content_tag(:div, key.to_s.capitalize << " " << val, class: "errors")) if key.eql?(:password) }
    end
    tag
	end
end

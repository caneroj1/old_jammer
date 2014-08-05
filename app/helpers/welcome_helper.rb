module WelcomeHelper
	def content_for_email_errors
		tag = content_tag(:div, "")
		if @musician.errors.any?
  		@musician.errors.each { |key, val| tag.concat(content_tag(:div, key.to_s.humanize.capitalize << " " << val, class: "errors")) if key.eql?(:email) }
    end
    tag
	end

	def content_for_password_errors
		tag = content_tag(:div, "")
		if @musician.errors.any?
			puts @musician.errors.inspect
  		@musician.errors.each { |key, val| tag.concat(content_tag(:div, key.to_s.humanize.capitalize << " " << val, class: "errors")) if password_check(key) }
    end
    tag
	end

	def password_check(key)
		key.eql?(:password) || key.eql?(:password_confirmation)
	end

	def email_check(key)
		key.eql?(:email) || key.eql?(:change_email)
	end
end

module ApplicationHelper
	def new_messages?
		content_tag(:span) do
			"You have new messages"
		end
	end
end

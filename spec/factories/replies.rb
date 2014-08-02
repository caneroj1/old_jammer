require 'faker'

FactoryGirl.define do
	factory :reply do
		sent_by { Faker::Number.digit }
		reply_body { Faker::Hacker.say_something_smart }

		factory :reply_with_sender do
			after(:create) do |reply|
				message = FactoryGirl.create(:message_with_users, :for_booking)
				reply.message = message
				reply.sent_by = message.sent_by
			end
		end
	end
end
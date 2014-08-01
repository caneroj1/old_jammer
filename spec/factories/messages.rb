require 'faker'

FactoryGirl.define do
	factory :message do
		subject { Faker::Lorem.sentence }
		message_body { Faker::Hacker.say_something_smart }
		sent_by { Faker::Number.digit }

		trait :for_lessons do
			lesson_request true
		end

		trait :for_jam do
			jam_request true
		end

		trait :for_booking do
			booking_request true
		end

		factory :message_with_replies do
			after(:create) do |message|
				message.replies << FactoryGirl.create(:reply)
			end
		end

		factory :sent_message do
			after(:create) do |message|
				message.users << FactoryGirl.create(:user)
			end
		end
	end
end
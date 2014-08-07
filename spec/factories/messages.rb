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

		factory :message_with_users do
			after(:create) do |message|
				u1 = FactoryGirl.build(:user, :has_avatar, first_name: "joe", last_name: "canero")
				u2 = FactoryGirl.build(:user, :has_avatar, first_name: "john", last_name: "bobby")
				message.users << u1 << u2
				message.sent_by = u1.id
			end
		end

		factory :message_with_reply do
			after(:create) do |message|
				reply = FactoryGirl.build(:reply)
				message.replies << reply
			end
		end
	end
end
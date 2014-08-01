require 'faker'

FactoryGirl.define do
	factory :reply do
		sent_by { Faker::Number.digit }
		reply_body { Faker::Hacker.say_something_smart }
	end
end
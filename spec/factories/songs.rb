require 'faker'

FactoryGirl.define do
	factory :song do
		song_name "#{Faker::Name.first_name}'s Big Song"
		url { Faker::Internet.url }
		song_number 1
	end
end
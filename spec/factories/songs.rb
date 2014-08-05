FactoryGirl.define do
	factory :song do
		song_name "#{Faker::Name.first_name}'s Big Song"
		url { Faker::Internet.url }
		song_number 1

		factory :song_with_ext_in_name do
			trait :mp3 do
				song_name "Big Song.mp3"
			end

			trait :m4a do
				song_name "Big Song.m4a"
			end

			trait :mpeg do
				song_name "Big Song.mpeg"
			end
		end
	end
end